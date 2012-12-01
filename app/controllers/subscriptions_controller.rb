class SubscriptionsController < ApplicationController

  before_filter :find_owned_resources
  before_filter :find_resource, only: %w(show update destroy)
  before_filter :search_params, only: %w(index)
  before_filter :pagination,    only: %w(index)

  def index
    @subscriptions = @subscriptions.limit(params[:per])
    render json: @subscriptions
  end

  def show
    render json: @subscription if stale?(@subscription)
  end

  def create
    @subscription = Subscription.new(params)
    @subscription.client_id = current_client.id
    if @subscription.save
      render json: @subscription, status: 201, subscription: SubscriptionDecorator.decorate(@subscription).uri
    else
      render_422 'notifications.resource.not_valid', @subscription.errors
    end
  end

  def update
    if @subscription.update_attributes(params)
      render json: @subscription
    else
      render_422 'notifications.resource.not_valid', @subscription.errors
    end
  end

  def destroy
    render json: @subscription
    @subscription.destroy
  end

  private

  def find_owned_resources
    @subscriptions = Subscription.where(client_id: current_client.id)
  end

  def find_resource
    @subscription = @subscriptions.find(params[:id])
  end

  def search_params
    @subscriptions = @subscriptions.where(resource: params[:resource]) if params[:resource]
    @subscriptions = @subscriptions.where(event: params[:event])       if params[:event]
  end

  def pagination
    params[:per] = (params[:per] || Settings.pagination.per).to_i
    params[:per] = Settings.pagination.per if params[:per] == 0
    params[:per] = Settings.pagination.max_per if params[:per] > Settings.pagination.max_per
    @subscriptions = @subscriptions.gt(id: find_id(params[:start])) if params[:start]
  end
end


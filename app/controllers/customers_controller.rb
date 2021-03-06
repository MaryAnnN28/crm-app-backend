class CustomersController < ApplicationController

   def index
      render json: Customer.all.to_json(customer_serializer_options)
   end

   def show
      customer = Customer.find(params[:id])
      render json: customer.to_json(customer_serializer_options)
   end

   def create
      customer = Customer.create(customer_params)
      render json: customer
   end

   def update
      Customer.find(params[:id]).update(customer_params)
      render json: Customer.find(params[:id])
   end

   def destroy
      customer = Customer.find(params[:id]).destroy
      render json: Customer.all.to_json(customer_serializer_options)
   end

   private

   def customer_params
      params.require(:customer).permit(:first_name, :last_name, :company, :job_title, :industry, :email, :phone, :notes, :user_id, :task_id)
   end

   def customer_serializer_options()
      {
         include: {
            tasks: {
               except: [:updated_at]
            } 
         }
      }
   end

end

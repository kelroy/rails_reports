class ReportsController < ApplicationController
  
  def index
    @positive = { "store_credit" => 0,
                  "check" => 0,
                  "credit_card" => 0,
                  "gift_card" => 0,
                  "cash" => 0,
                  "tax" => 0,
                }
    @negative = { "store_credit" => 0,
                  "check" => 0,
                  "gift_card" => 0,
                  "cash" => 0,
                }
    if params[:start_date]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      
      if params[:commit] == "Previous Day"
        @start_date.advance(-1.day)
        @end_date.advance(-1.day)
      elsif params[:commit] == "Next Day"
        @start_date.advance(1.day)
        @end_date.advance(1.day)
      end
      
      @transactions = Transaction.find(:all, :conditions => {:created_at => DateTime.parse(@start_date.to_s).beginning_of_day..DateTime.parse(@end_date.to_s).end_of_day})
      
      
      @transactions.each do |transaction|
        if transaction.lines
          transaction.lines.each do |line|
            if line[:price] == nil
               line[:price] = 0
            end
            
            if line[:quantity] == nil
               line[:quantity] = 0
            end
            
            if line[:price] > 0
              @payments = Payment.where( :transaction_id => transaction[:id])
              @payments.each do |payment|
                if payment[:form] = "store_credit"
                  line[:quantity].to_i + 1
                  line[:price].to_i + 1
                  @positive[:store_credit] =  line[:quantity].to_i * line[:price].to_i + @positive[:store_credit].to_i
                else
                  if payment[:form] = "check"
                    line[:quantity].to_i
                    line[:price].to_i
                    @positive[:check] = line[:quantity].to_i * line[:price].to_i + @positive[:check].to_i
                  elsif payment[:form] = "credit_card"
                    @positive[:credit_card] = line[:quantity].to_i * line[:price].to_i + @positive[:credit_card].to_i
                  elsif payment[:form] = "gift_card"
                    @positive[:gift_card] = line[:quantity].to_i * line[:price].to_i + @positive[:gift_card].to_i
                  else
                    @positive[:cash] = line[:quantity].to_i * line[:price].to_i + @positive[:cash].to_i
                  end
                    if line[:taxable] == 1
                      @positive[:tax] = @positive[:tax] + line[:price].to_i*transaction[:taxrate].to_f
                    end
                end
              end
            elsif line[:price] != nil
              
            end
          end
        end
      end
      
    else
      @start_date = Time.now.strftime("%Y-%m-%d")
      @end_date = @start_date
    end
  end
  
  def range 
    
    
    
  end

end

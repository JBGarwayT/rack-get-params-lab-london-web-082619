class Application

  @@items = ["Apples","Carrots","Pears"]

  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.count == 0
        resp.write "Your cart is empty"
      elsif @@cart.length > 0
        @@cart.each do |item|
        resp.write "\n#{item}"
        end
      end
    elsif req.path.match(/add/)
      search_item = req.params["item"]
      if !@@items.include?(search_item)
        resp.write "We don't have that item"
      else 
        # @@items.include?(search_term)
        @@cart << search_item
        resp.write "added #{search_item}"
      end
      # resp.write add(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  # def add(search_term)
  #   if !@@items.include?(search_term)
  #     return "We don't have that item"
  #   else 
  #     # @@items.include?(search_term)
  #     @@cart << search_term
  #     return "added #{search_term}"
  #   end
  # end
end

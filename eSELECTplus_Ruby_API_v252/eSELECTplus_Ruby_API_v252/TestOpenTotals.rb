#!c:\ruby\bin\rubyw.exe

require './mpgapi4r.rb'

p = ReqMod::Opentotals.new

p.ecr_number = "66002163"

r = ReqMod::Request.new

r.store_id = 'store5'
r.api_token = 'yesguy'

r.opentotals = p

response = HttpsPoster.post(r)

#loop through all card types
response.receipt.banktotals.ecr.card.each do |x|
	if x.cardtype != nil
		print "\n\nCard type = " + x.cardtype
		print "\nPurchase Count = " + x.purchase.count
		print "\nPurchase Amount = " + x.purchase.amount
		print "\nRefund Count = " + x.refund.count
		print "\nRefund Amount = " + x.refund.amount
		print "\nCorrection Count = " + x.correction.count
		print "\nCorrection Amount = " + x.correction.amount
	end
end
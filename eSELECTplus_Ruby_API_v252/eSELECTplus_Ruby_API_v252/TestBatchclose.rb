#!c:\ruby\bin\rubyw.exe

require './mpgapi4r.rb' #path to mpgapi4r.rb

r = ReqMod::Request.new

r.store_id = 'store5'
r.api_token = 'yesguy'

batchclose = ReqMod::Batchclose.new
batchclose.ecr_number = '66002163'

r.batchclose = batchclose

response = HttpsPoster.post(r)

print "\nTerminal ID = " + response.receipt.banktotals.ecr.term_id
print "\nClosed = " + response.receipt.banktotals.ecr.closed

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
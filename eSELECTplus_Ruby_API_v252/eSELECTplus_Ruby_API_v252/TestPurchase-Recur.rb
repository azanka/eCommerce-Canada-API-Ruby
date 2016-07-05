#!/usr/local/bin/ruby

require './mpgapi4r.rb'

p = ReqMod::Purchase.new
rec = ReqMod::RecurInfo.new
p.recur=rec

p.order_id = "rubyapitest12"
p.cust_id = "2:30:04 tuesday/december/1981"
p.amount = "1.00"
p.crypt_type = "2"

p.pan = "4242424242424242"
p.expdate = "1111"

#recur variables
p.recur.recur_unit = "day" #end of month = "eom"
p.recur.start_date = "2006/11/30"
p.recur.num_recurs = "4"
p.recur.period = "10"
p.recur.recur_amount = "31.00"
p.recur.start_now = "true"

r = ReqMod::Request.new

r.store_id = 'store3'
r.api_token = 'yesguy'

r.purchase = p




response = HttpsPoster.post(r)
print "\nCard Type = " + response.receipt.cardtype.to_s
print "\nTransaction Amount = " + response.receipt.transamount.to_s
print "\nTxnNumber = " + response.receipt.transid.to_s
print "\nReceiptID = " + response.receipt.receiptid.to_s
print "\nTransaction Type = " + response.receipt.transtype.to_s
print "\nReference Number = " + response.receipt.referencenum.to_s
print "\nResponse Code = " + response.receipt.responsecode.to_s
print "\nISO = " + response.receipt.iso.to_s
print "\nMessage = " + response.receipt.message.to_s
print "\nAuthcode = " + response.receipt.authcode.to_s
print "\nComplete = " + response.receipt.complete.to_s
print "\nTransaction Date = " + response.receipt.transdate.to_s
print "\nTransaction Time = " + response.receipt.transtime.to_s
print "\nTicket = " + response.receipt.ticket.to_s
print "\nTimedOut = " + response.receipt.timedout.to_s
if response.receipt.recursuccess != nil
	print "\nRecurSuccess = " + response.receipt.recursuccess.to_s
end
#!/usr/local/bin/ruby

require './mpgapi4r.rb'

p = ReqMod::IndRefund.new

p.order_id = "rubyindependentref7a"
p.amount = "1.00"
p.cust_id = "customer id"
p.pan = "4242424242424242"
p.expdate = "0909"
p.crypt_type = "7"


r = ReqMod::Request.new

r.store_id = 'store5'
r.api_token = 'yesguy'

r.ind_refund = p

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

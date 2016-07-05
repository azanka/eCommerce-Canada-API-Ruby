#!c:\ruby\bin\rubyw.exe
require './mpgapi4r.rb' #path to mpgapi4r.rb 
require './xml.rb'

p = ReqMod::RecurUpdate.new

p.order_id = "mrt0190136352"
p.cust_id = "bob"
p.recur_amount = "21.00"
p.pan = "5454545454545454"
p.expdate = "1111"
#p.add_num_recurs = "2"
#p.total_num_recurs = "100"
#p.hold = "true"
#p.terminate = "false"

r = ReqMod::Request.new

r.store_id = 'store5'
r.api_token = 'yesguy'

r.recur_update = p

response = HttpsPoster.post(r)
print "\nReceiptID = " + response.receipt.receiptid.to_s
print "\nResponse Code = " + response.receipt.responsecode.to_s
print "\nMessage = " + response.receipt.message.to_s
print "\nComplete = " + response.receipt.complete.to_s
print "\nTransaction Date = " + response.receipt.transdate.to_s
print "\nTransaction Time = " + response.receipt.transtime.to_s
print "\nTimedOut = " + response.receipt.timedout.to_s
print "\nRecurUpdateSuccess = " + response.receipt.recurupdatesuccess.to_s
print "\nNextRecurDate = " + response.receipt.nextrecurdate.to_s
print "\nRecurEndDate = " + response.receipt.recurenddate.to_s

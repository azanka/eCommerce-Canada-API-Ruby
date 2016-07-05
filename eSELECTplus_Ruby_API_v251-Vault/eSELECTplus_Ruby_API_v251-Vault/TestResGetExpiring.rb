#!c:\ruby\bin\rubyw.exe
require './mpgapi4r.rb' #path to usmpgapi4r.rb 
p = ReqMod::ResGetExpiring.new

r = ReqMod::Request.new

r.store_id = 'store5'
r.api_token = 'yesguy'

r.res_get_expiring = p

response = HttpsPoster.post(r)
print "\nDataKey = " + response.receipt.datakey.to_s
print "\nResponse Code = " + response.receipt.responsecode.to_s
print "\nMessage = " + response.receipt.message.to_s
print "\nTransaction Date = " + response.receipt.transdate.to_s
print "\nTransaction Time = " + response.receipt.transtime.to_s
print "\nComplete = " + response.receipt.complete.to_s
print "\nTimedOut = " + response.receipt.timedout.to_s
print "\nResSuccess = " + response.receipt.ressuccess.to_s
print "\nPaymentType = " + response.receipt.paymenttype.to_s

response.receipt.resolvedata.each do |x|
  print "\n\nData Key = " + x.data_key.to_s
  print "\n\nPayment Type = " + x.payment_type.to_s
  print "\nCust ID = " + x.cust_id.to_s
  print "\nPhone = " + x.phone.to_s
  print "\nEmail = " + x.email.to_s
  print "\nNote = " + x.note.to_s
  print "\nMasked Pan = " + x.masked_pan.to_s
  print "\nExp Date = " + x.expdate.to_s
  print "\nCrypt Type = " + x.crypt_type.to_s
  print "\nAvs Street Number = " + x.avs_street_number.to_s
  print "\nAvs Street Name = " + x.avs_street_name.to_s
  print "\nAvs Zipcode = " + x.avs_zipcode.to_s
end
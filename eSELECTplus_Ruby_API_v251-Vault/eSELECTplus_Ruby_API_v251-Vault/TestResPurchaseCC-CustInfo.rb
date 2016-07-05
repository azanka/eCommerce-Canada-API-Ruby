#!c:\ruby\bin\rubyw.exe
require './mpgapi4r.rb' #path to usmpgapi4r.rb 
p = ReqMod::ResPurchaseCC.new

r = ReqMod::Request.new
c = ReqMod::CustInfo.new
b = ReqMod::Billing.new
s = ReqMod::Shipping.new
i = ReqMod::Item.new

p.cust_info=c
p.cust_info.billing=b
p.cust_info.shipping=s
p.cust_info.item=i


r.store_id = 'store5'
r.api_token = 'yesguy'

p.data_key = "k8n3X9E2h79VNPf3888331tpt"
p.order_id = "rubyrespurchasecctest4"
p.cust_id = "john smith"
p.amount = "1.00"
p.crypt_type = "1"

#Customer Information Variables
#E-mail
p.cust_info.email="Joe@widgets.com"

#Instructions
p.cust_info.instructions="Make it fast"

#Billing Information
p.cust_info.billing.first_name = "Joe"
p.cust_info.billing.last_name = "Thompson"
p.cust_info.billing.company_name = "Widget Company Inc."
p.cust_info.billing.address = "111 Bolts Ave."
p.cust_info.billing.city = "Toronto"
p.cust_info.billing.province = "Ontario"
p.cust_info.billing.country = "Canada"
p.cust_info.billing.postal_code = "M8T 1T8"
p.cust_info.billing.phone_number = "416-555-5555"
p.cust_info.billing.fax = "416-555-5555"
p.cust_info.billing.tax1 = "123.45"
p.cust_info.billing.tax2 = "123.45"
p.cust_info.billing.tax3 = "15.45"
p.cust_info.billing.shipping_cost = "456.23"

#Shipping Information
p.cust_info.shipping.first_name = "Joe"
p.cust_info.shipping.last_name = "Thompson"
p.cust_info.shipping.company_name = "Widget Company Inc."
p.cust_info.shipping.address = "111 Bolts Ave."
p.cust_info.shipping.city = "Toronto"
p.cust_info.shipping.province = "Ontario"
p.cust_info.shipping.country = "Canada"
p.cust_info.shipping.postal_code = "M8T 1T8"
p.cust_info.shipping.phone_number = "416-555-5555"
p.cust_info.shipping.fax = "416-555-5555"
p.cust_info.shipping.tax1 = "123.45"
p.cust_info.shipping.tax2 = "123.45"
p.cust_info.shipping.tax3 = "15.45"
p.cust_info.shipping.shipping_cost = "456.23"

#Item Information
i1 = ReqMod::Item.new
i1.name = "item1 name"
i1.quantity = "53"
i1.product_code = "item1 product code"
i1.extended_amount = "1.00"

i2 = ReqMod::Item.new
i2.name = "item2 name"
i2.quantity = "24"
i2.product_code = "item2 product code"
i2.extended_amount = "1.00"

p.cust_info.item = Array.new
p.cust_info.item << i1 << i2

r.res_purchase_cc = p

response = HttpsPoster.post(r)
print "\nDataKey = " + response.receipt.datakey.to_s
print "\nReceiptId = " + response.receipt.receiptid.to_s
print "\nReferenceNum = " + response.receipt.referencenum.to_s
print "\nResponse Code = " + response.receipt.responsecode.to_s
print "\nAuthCode = " + response.receipt.authcode.to_s
print "\nMessage = " + response.receipt.message.to_s
print "\nTransaction Date = " + response.receipt.transdate.to_s
print "\nTransaction Time = " + response.receipt.transtime.to_s
print "\nTransaction Type = " + response.receipt.transtype.to_s
print "\nComplete = " + response.receipt.complete.to_s
print "\nTransaction Amount = " + response.receipt.transamount.to_s
print "\nCard Type = " + response.receipt.cardtype.to_s
print "\nTxn Number = " + response.receipt.txnnumber.to_s
print "\nTimedOut = " + response.receipt.timedout.to_s
print "\nResSuccess = " + response.receipt.ressuccess.to_s
print "\nPaymentType = " + response.receipt.paymenttype.to_s
print "\nAVSResponse = " + response.receipt.avsresultcode.to_s

#ResolveData
print "\n\nCust ID = " + response.receipt.resolvedata[0].cust_id.to_s
print "\nPhone = " + response.receipt.resolvedata[0].phone.to_s
print "\nEmail = " + response.receipt.resolvedata[0].email.to_s
print "\nNote = " + response.receipt.resolvedata[0].note.to_s
print "\nMasked Pan = " + response.receipt.resolvedata[0].masked_pan.to_s
print "\nExpdate = " + response.receipt.resolvedata[0].expdate.to_s
print "\nCrypt Type = " + response.receipt.resolvedata[0].crypt_type.to_s
print "\nAvs Street Number = " + response.receipt.resolvedata[0].avs_street_number.to_s
print "\nAvs Street Name = " + response.receipt.resolvedata[0].avs_street_name.to_s
print "\nAvs Zipcode = " + response.receipt.resolvedata[0].avs_zipcode.to_s
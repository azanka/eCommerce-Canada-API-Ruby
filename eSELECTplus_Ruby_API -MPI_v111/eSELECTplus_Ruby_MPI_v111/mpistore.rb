#!c:\ruby\bin\rubyw.exe

require '../mpiapi4r.rb' #path to mpiapi4r.rb

r = Mpirequest.new

r.store_id = "moneris"
r.api_token = "hurgle"

t = Txn.new
r.txn = t

#random 20-digit xid
xid = Integer(rand()*100000000000000000000)

r.txn.xid = xid.to_s
r.txn.amount = "1.00"
r.txn.pan = "4242424242424242"
r.txn.expdate = "1111"

r.txn.md = xid.to_s + "&" + r.txn.pan + "&" + r.txn.expdate + "&" + r.txn.amount

r.txn.merchanturl = "www.google.com"
r.txn.accept = "null"
r.txn.useragent = "Ruby MPI v1.0"

mpiresponse = MpiHttpsPoster.post(r)

print "\nType = " + mpiresponse.type
print "\nSuccess = " + mpiresponse.success
print "\nMessage = " + mpiresponse.message
print "\nPaReq = " + mpiresponse.pareq

if mpiresponse.message == "Y"
	print "\nFunction to display MpiInLineform"
else
	if mpiresponse.message = "U"
			#merchant assumes liability for chargeback
			crypt_type = "7"
	else
			#merchant is not liable for chargeback (attempt was made)
			crypt_type = "6"
	end
	
	require '../mpgapi4r.rb'
	#send regular transaction with appropriate ECR
	
	p = ReqMod::Purchase.new
	p.order_id = "testrubyvbvorder2"
	p.cust_id = "customer id"
	p.amount = "1.00"
	p.pan = "4242424242424242"
	p.expdate = "1111"
	p.crypt_type = crypt_type
	
	req = ReqMod::Request.new

	req.store_id = r.store_id
	req.api_token = r.api_token

	req.purchase = p
	
	response = HttpsPoster.post(req)
	
	print "\nResponse = " + response.receipt.message
	print "\nVBV Response = " + mpiresponse.message
	print "\nCrypt Type = " + crypt_type
end

#PaRes is the variable received from the ACS
if crypt_type == null#pares == nil
	
	acsr = Mpirequest.new
	acsr.store_id = "moneris"
	acsr.api_token = "hurgle"
	
	a = Acs.new
	acsr.acs = a
	acsr.acs.pares = crypt_type #pares
	acsr.acs.md = r.txn.md
		
	acsresponse = MpiHttpsPoster.post(acsr)
	
	print "\nMpiResponse Success  = " + acsresponse.success
	

	if acsresponse.success == "true"
		require "../mpgapi4r.rb"
		order_id = Integer(rand()*100000000000000000000)
		cavv = acsresponse.cavv
		
		cp = ReqMod::CavvPurchase.new
		cp.order_id = order_id
		cp.amount = "1.00"
		cp.pan = "4242424242424242"
		cp.expdate = "1111"
		cp.cavv = cavv
		
		cavvresponse = HttpsPoster.post(cp)
		
		print "\nThe message is:  " + response.receipt.message
	else
		#At this point, the merchant should reject the transaction
		print "\nSuccess = " + acsresponse.success
		print "\nMessage = " + acsresponse.message

	end
else
	print "The main form goes here"
end

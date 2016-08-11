#!c:\ruby\bin\rubyw.exe

require_relative 'mpiapi4r.rb' #path to mpiapi4r.rb

r = Mpirequest.new

r.store_id = "store_id"
r.api_token = "api_token"

t = Txn.new
r.txn = t

# Expiration date
def expiration_date
	@expiration_date = begin
		(Date.today + 365).strftime "%y%m"
	end
end


#random 20-digit xid
xid = Integer(rand()*100000000000000000000)

r.txn.xid = xid.to_s
r.txn.amount = "1.00"
r.txn.pan = "4242424242424242"
r.txn.expdate = expiration_date

r.txn.md = xid.to_s + "&" + r.txn.pan + "&" + r.txn.expdate + "&" + r.txn.amount

r.txn.merchanturl = "www.google.com"
r.txn.accept = "null"
r.txn.useragent = "Ruby MPI v1.0"

mpiresponse = MpiHttpsPoster.post(r)

puts "\nType = " + mpiresponse.type
puts "\nSuccess = " + mpiresponse.success
puts "\nMessage = " + mpiresponse.message
puts "\nPaReq = " + mpiresponse.pareq

puts "*"*80
p mpiresponse
puts "="*80

if mpiresponse.message == "Y"
	puts "\nFunction to display MpiInLineform"
else
	if mpiresponse.message = "U"
			#merchant assumes liability for chargeback
			crypt_type = "7"
	else
			#merchant is not liable for chargeback (attempt was made)
			crypt_type = "6"
	end

	require_relative '../../eSELECTplus_Ruby_API_v252/eSELECTplus_Ruby_API_v252/mpgapi4r.rb'
	#send regular transaction with appropriate ECR

	p = ReqMod::Purchase.new
	p.order_id = SecureRandom.hex
	p.cust_id = SecureRandom.hex
	p.amount = "1.00"
	p.pan = "4242424242424242"
	p.expdate = expiration_date
	p.crypt_type = crypt_type

	req = ReqMod::Request.new

	req.store_id = r.store_id
	req.api_token = r.api_token

	req.purchase = p

	response = HttpsPoster.post(req)

	puts "\nResponse = " + response.receipt.message
	puts "\nVBV Response = " + mpiresponse.message
	puts "\nCrypt Type = " + crypt_type
end

#PaRes is the variable received from the ACS
if crypt_type == nil#pares == nil

	acsr = Mpirequest.new
	acsr.store_id = "moneris"
	acsr.api_token = "hurgle"

	a = Acs.new
	acsr.acs = a
	acsr.acs.pares = crypt_type #pares
	acsr.acs.md = r.txn.md

	acsresponse = MpiHttpsPoster.post(acsr)

	puts "\nMpiResponse Success  = " + acsresponse.success


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

		puts "\nThe message is:  " + response.receipt.message
	else
		#At this point, the merchant should reject the transaction
		puts "\nSuccess = " + acsresponse.success
		puts "\nMessage = " + acsresponse.message

	end
else
	puts "The main form goes here"
end

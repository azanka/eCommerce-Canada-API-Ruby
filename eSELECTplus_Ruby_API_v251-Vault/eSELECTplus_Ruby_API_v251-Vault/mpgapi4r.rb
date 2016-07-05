require 'net/https'
require 'uri'
require './xml.rb' #path to xml.rb
require 'rexml/document'

class HttpsPoster

  @@uri = URI.parse("https://esqa.moneris.com") 

  def HttpsPoster.post(mpg_request)
    http = Net::HTTP.new(@@uri.host,@@uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    puts "Sending:\n#{mpg_request.to_xml}"

    response = RespMod::Response.new
    
    http.start {
      http.request_post("/gateway2/servlet/MpgRequest",mpg_request.to_xml, {'User-Agent' => 'RUBY - 2.5.1 - Resolver'}) {|res|
        response.from_xml(res.body)
      }
    }
    
    return response
  end
end

############ Request Classes ###################
module ReqMod
class Request < Xml
  @@keys = ["store_id","api_token","status_check","purchase","cavv_purchase","refund",
  "ind_refund","preauth","cavv_preauth","forcepost","completion",
  "purchasecorrection","batchclose","opentotals","idebit_purchase",
  "idebit_refund","recur_update","res_add_cc","res_update_cc","res_delete",
  "res_lookup_full","res_lookup_masked","res_get_expiring","res_purchase_cc",
  "res_preauth_cc","res_ind_refund_cc","res_iscorporatecard","res_add_token","res_tokenize_cc","res_card_verification_cc"]
  make_attrs(Request,@@keys)

  def to_xml(indent="")
    to_xml_low("request",@@keys,indent)
  end
end

class Purchase < Xml
  @@keys = ["order_id","cust_id","amount","pan","expdate","crypt_type","cust_info","recur","avs_info","cvd_info","dynamic_descriptor"]
  make_attrs(Purchase,@@keys)

  def to_xml(indent="")
    to_xml_low("purchase",@@keys,indent)
  end
end

class Preauth < Xml
  @@keys = ["order_id","cust_id","amount","pan","expdate","crypt_type","cust_info","avs_info","cvd_info","dynamic_descriptor"]
  make_attrs(Preauth,@@keys)

  def to_xml(indent="")
    to_xml_low("preauth",@@keys,indent)
  end
end

class CavvPurchase < Xml
  @@keys = ["order_id","cust_id","amount","pan","expdate","cavv","cust_info","avs_info","cvd_info","dynamic_descriptor"]
  make_attrs(CavvPurchase,@@keys)

  def to_xml(indent="")
    to_xml_low("cavv_purchase",@@keys,indent)
  end
end

class CavvPreauth < Xml
  @@keys = ["order_id","cust_id","amount","pan","expdate","cavv","cust_info","avs_info","cvd_info","dynamic_descriptor"]
  make_attrs(CavvPreauth,@@keys)

  def to_xml(indent="")
    to_xml_low("cavv_preauth",@@keys,indent)
  end
end

class Refund < Xml
  @@keys = ["order_id","amount","txn_number","crypt_type"]
  make_attrs(Refund,@@keys)

  def to_xml(indent="")
    to_xml_low("refund",@@keys,indent)
  end
end

class IndRefund < Xml
  @@keys = ["order_id","cust_id","amount","pan","expdate","crypt_type","dynamic_descriptor"]
  make_attrs(IndRefund,@@keys)

  def to_xml(indent="")
    to_xml_low("ind_refund",@@keys,indent)
  end
end

class Forcepost < Xml
  @@keys = ["order_id","cust_id","amount","pan","expdate","auth_code","crypt_type","cust_info"]
  make_attrs(Forcepost,@@keys)

  def to_xml(indent="")
    to_xml_low("forcepost",@@keys,indent)
  end
end

class Completion < Xml
  @@keys = ["order_id","comp_amount","txn_number","crypt_type"]
  make_attrs(Completion,@@keys)

  def to_xml(indent="")
    to_xml_low("completion",@@keys,indent)
  end
end

class Purchasecorrection < Xml
  @@keys = ["order_id","txn_number","crypt_type"]
  make_attrs(Purchasecorrection,@@keys)

  def to_xml(indent="")
    to_xml_low("purchasecorrection",@@keys,indent)
  end
end

class IdebitPurchase < Xml
  @@keys = ["order_id", "amount", "idebit_track2"]
  make_attrs(IdebitPurchase,@@keys)

  def to_xml(indent="")
    to_xml_low("idebit_purchase",@@keys,indent)
  end
end

class IdebitRefund < Xml
  @@keys = ["order_id", "amount", "txn_number"]
  make_attrs(IdebitRefund,@@keys)

  def to_xml(indent="")
    to_xml_low("idebit_refund",@@keys,indent)
  end
end

class PurchaseReversal < Xml
  @@keys = ["order_id", "amount"]
  make_attrs(PurchaseReversal,@@keys)

  def to_xml(indent="")
    to_xml_low("purchase_reversal",@@keys,indent)
  end
end

class Batchclose < Xml
  @@keys = ["ecr_number"]
  make_attrs(Batchclose,@@keys)

  def to_xml(indent="")
    to_xml_low("batchclose",@@keys,indent)
  end
end

class Opentotals < Xml
  @@keys = ["ecr_number"]
  make_attrs(Opentotals,@@keys)

  def to_xml(indent="")
    to_xml_low("opentotals",@@keys,indent)
  end
end

class CustInfo < Xml
  @@keys = ["billing","shipping","email","instructions","item"]
  make_attrs(CustInfo,@@keys)

  def to_xml(indent="")
    to_xml_low("cust_info",@@keys,indent)
  end
end

class RecurInfo < Xml
  @@keys = ["recur_unit","start_now","start_date","num_recurs","period","recur_amount"]
  make_attrs(RecurInfo,@@keys)

  def to_xml(indent="")
    to_xml_low("recur",@@keys,indent)
  end
end

class CVDInfo < Xml
  @@keys = ["cvd_indicator","cvd_value"]
  make_attrs(CVDInfo,@@keys)

  def to_xml(indent="")
    to_xml_low("cvd_info",@@keys,indent)
  end
end

class AVSInfo < Xml
  @@keys = ["avs_street_number","avs_street_name","avs_zipcode"]
  make_attrs(AVSInfo,@@keys)

  def to_xml(indent="")
    to_xml_low("avs_info",@@keys,indent)
  end
end

class Billing < Xml
  @@keys = ["first_name","last_name","company_name","address","city","province","postal_code","country","phone_number","fax","tax1","tax2","tax3","shipping_cost"]
  make_attrs(Billing,@@keys)

  def to_xml(indent="")
    to_xml_low("billing",@@keys,indent)
  end
end

class Shipping < Xml
  @@keys = ["first_name","last_name","company_name","address","city","province","postal_code","country","phone_number","fax","tax1","tax2","tax3","shipping_cost"]
  make_attrs(Shipping,@@keys)

  def to_xml(indent="")
    to_xml_low("shipping",@@keys,indent)
  end
end

class Item < Xml
  @@keys = ["name","quantity","product_code","extended_amount"]
  make_attrs(Item,@@keys)

  def to_xml(indent="")
      to_xml_low("item",@@keys,indent)
  end
end

class RecurUpdate < Xml
  @@keys = ["order_id","cust_id","recur_amount","pan","expdate","add_num_recurs","total_num_recurs","hold","terminate"]
  make_attrs(RecurUpdate,@@keys)

  def to_xml(indent="")
    to_xml_low("recur_update",@@keys,indent)
  end
end

class ResAddCC < Xml
  @@keys = ["cust_id","phone","email","note","pan","expdate","crypt_type","avs_info"]
  make_attrs(ResAddCC,@@keys)

  def to_xml(indent="")
    to_xml_low("res_add_cc",@@keys,indent)
  end
end

class ResAddToken < Xml
  @@keys = ["data_key","cust_id","phone","email","note","expdate","crypt_type","avs_info"]
  make_attrs(ResAddToken,@@keys)

  def to_xml(indent="")
    to_xml_low("res_add_token",@@keys,indent)
  end
end

class ResCardVerificationCC < Xml
  @@keys = ["data_key","order_id","cust_id","expdate","crypt_type","cvd_info","avs_info"]
  make_attrs(ResCardVerificationCC,@@keys)

  def to_xml(indent="")
    to_xml_low("res_card_verification_cc",@@keys,indent)
  end
end

class ResIscorporatecard < Xml
  @@keys = ["data_key"]
  make_attrs(ResIscorporatecard,@@keys)

  def to_xml(indent="")
    to_xml_low("res_iscorporatecard",@@keys,indent)
  end
end

class ResDelete < Xml
  @@keys = ["data_key"]
  make_attrs(ResDelete,@@keys)

  def to_xml(indent="")
    to_xml_low("res_delete",@@keys,indent)
  end
end

class ResGetExpiring < Xml
  @@keys = []
  make_attrs(ResGetExpiring,@@keys)

  def to_xml(indent="")
    to_xml_low("res_get_expiring",@@keys,indent)
  end
end

class ResIndRefundCC < Xml
  @@keys = ["data_key","order_id","cust_id","amount","crypt_type"]
  make_attrs(ResIndRefundCC,@@keys)

  def to_xml(indent="")
    to_xml_low("res_ind_refund_cc",@@keys,indent)
  end
end

class ResLookupFull < Xml
  @@keys = ["data_key"]
  make_attrs(ResLookupFull,@@keys)

  def to_xml(indent="")
    to_xml_low("res_lookup_full",@@keys,indent)
  end
end

class ResLookupMasked < Xml
  @@keys = ["data_key"]
  make_attrs(ResLookupMasked,@@keys)

  def to_xml(indent="")
    to_xml_low("res_lookup_masked",@@keys,indent)
  end
end

class ResPreauthCC < Xml
  @@keys = ["data_key","order_id","cust_id","amount","crypt_type","cust_info","avs_info","cvd_info","dynamic_descriptor"]
  make_attrs(ResPreauthCC,@@keys)

  def to_xml(indent="")
    to_xml_low("res_preauth_cc",@@keys,indent)
  end
end

class ResPurchaseCC < Xml
  @@keys = ["data_key","order_id","cust_id","amount","crypt_type","cust_info","avs_info","cvd_info","recur","dynamic_descriptor"]
  make_attrs(ResPurchaseCC,@@keys)

  def to_xml(indent="")
    to_xml_low("res_purchase_cc",@@keys,indent)
  end
end

class ResTokenizeCC < Xml
  @@keys = ["order_id","txn_number","cust_id","phone","email","note","avs_info"]
  make_attrs(ResTokenizeCC,@@keys)

  def to_xml(indent="")
    to_xml_low("res_tokenize_cc",@@keys,indent)
  end
end

class ResUpdateCC < Xml
  @@keys = ["data_key","cust_id","phone","email","note","pan","expdate","crypt_type","avs_info"]
  make_attrs(ResUpdateCC,@@keys)

  def to_xml(indent="")
    to_xml_low("res_update_cc",@@keys,indent)
  end
end

end
############## Response Classes ###################
module RespMod
class Response < Xml
        @@keys = ["receipt"]
        make_attrs(Response,@@keys)

        def to_xml(indent="")
                to_xml_low("response",@@keys,indent)
        end
        
        def from_xml(xml)
          doc = REXML::Document.new(xml)
          
          #doc.write($stdout, 1)
          
          receipt = RespMod::Receipt.new
          receipt.from_xml(doc.root().get_elements("receipt")[0])
          @map['receipt'] = receipt
          
        end
end

class Receipt < Xml
        @@keys = ["ReceiptId","ReferenceNum","ResponseCode","ISO",
        "AuthCode","TransTime","TransDate","TransType","Complete",
        "Message","TransAmount","CardType","TransID","TimedOut",
        "BankTotals","Ticket","RecurSuccess","AvsResultCode",
        "CvdResultCode","RecurUpdateSuccess","NextRecurDate",
        "RecurEndDate","HostReferenceNum","TransCardCode","TransCardType",
        "TxnNumber","HostTotals","InitData","DisplayText","ReceiptText",
        "CardHolderName","VoucherText","VoucherType","InitialAmount",
        "InitialBalance","BatchNo","CurrentBalance","Benefit",
        "Language","ErrorCode","ErrorMessage","ActivationCharge",
        "RemainingBalance","CardStatus","Card","DataKey","ResSuccess",
        "PaymentType","ResolveData","CorporateCard","status_code","status_message"]
        
        make_attrs(Receipt,@@keys)

        def to_xml(indent="")
               to_xml_low("receipt",@@keys,indent)
        end
        
        def from_xml(element)
        
          if element.get_elements("ReceiptId")[0] != nil
            @map['ReceiptId'] = element.get_elements("ReceiptId")[0].get_text.value
          end
          
          if element.get_elements("ReferenceNum")[0] != nil
            @map['ReferenceNum'] = element.get_elements("ReferenceNum")[0].get_text.value
          end
          
          if element.get_elements("ResponseCode")[0] != nil
            @map['ResponseCode'] = element.get_elements("ResponseCode")[0].get_text.value
          end
          
          if element.get_elements("ISO")[0] != nil
            @map['ISO'] = element.get_elements("ISO")[0].get_text.value
          end
          
          if element.get_elements("AuthCode")[0] != nil
            @map['AuthCode'] = element.get_elements("AuthCode")[0].get_text.value
          end
          
          if element.get_elements("TransTime")[0] != nil
            @map['TransTime'] = element.get_elements("TransTime")[0].get_text.value
          end 
          
          if element.get_elements("TransDate")[0] != nil
            @map['TransDate'] = element.get_elements("TransDate")[0].get_text.value            
          end

          if element.get_elements("TransType")[0] != nil
            @map['TransType'] = element.get_elements("TransType")[0].get_text.value
          end
          
          if element.get_elements("Complete")[0] != nil
            @map['Complete'] = element.get_elements("Complete")[0].get_text.value
          end
          
          if element.get_elements("Message")[0] != nil
            @map['Message'] = element.get_elements("Message")[0].get_text.value
          end
          
          if element.get_elements("status_code")[0] != nil
	    @map['status_code'] = element.get_elements("status_code")[0].get_text.value
          end
          
          if element.get_elements("status_message")[0] != nil
	    @map['status_message'] = element.get_elements("status_message")[0].get_text.value
          end
          
          if element.get_elements("TransAmount")[0] != nil
            @map['TransAmount'] = element.get_elements("TransAmount")[0].get_text.value
          end
          
          if element.get_elements("CardType")[0] != nil
            if ((element.get_elements("ReceiptId")[0] != nil) && (element.get_elements("ReceiptId")[0].get_text.value == "iscorporatecard"))
              @map['CardType'] = ""
            else
              @map['CardType'] = element.get_elements("CardType")[0].get_text.value
            end
          end  
            
          if element.get_elements("TransID")[0] != nil            
            @map['TxnNumber'] = element.get_elements("TransID")[0].get_text.value
          end
          
          if element.get_elements("TimedOut")[0] != nil
            @map['TimedOut'] = element.get_elements("TimedOut")[0].get_text.value
          end

          if element.get_elements("RecurSuccess")[0] != nil
            @map['RecurSuccess'] = element.get_elements("RecurSuccess")[0].get_text.value
          end
        
          if element.get_elements("AvsResultCode")[0] != nil
            @map['AvsResultCode'] = element.get_elements("AvsResultCode")[0].get_text.value
          end
          
          if element.get_elements("CvdResultCode")[0] != nil
            @map['CvdResultCode'] = element.get_elements("CvdResultCode")[0].get_text.value
          end
          
          if element.get_elements("RecurUpdateSuccess")[0] != nil
            @map['RecurUpdateSuccess'] = element.get_elements("RecurUpdateSuccess")[0].get_text.value
          end
        
          if element.get_elements("NextRecurDate")[0] != nil
            @map['NextRecurDate'] = element.get_elements("NextRecurDate")[0].get_text.value
          end
        
          if element.get_elements("RecurEndDate")[0] != nil
            @map['RecurEndDate'] = element.get_elements("RecurEndDate")[0].get_text.value
          end

          if element.get_elements("HostReferenceNum")[0] != nil
            @map['HostReferenceNum'] = element.get_elements("HostReferenceNum")[0].get_text
          end
          
          if element.get_elements("TransCardCode")[0] != nil
            @map['TransCardCode'] = element.get_elements("TransCardCode")[0].get_text
          end
          
          if element.get_elements("TransCardType")[0] != nil
            @map['TransCardType'] = element.get_elements("TransCardType")[0].get_text
          end
          
          if element.get_elements("TxnNumber")[0] != nil
            @map['TxnNumber'] = element.get_elements("TxnNumber")[0].get_text
          end
          
          if element.get_elements("TimedOut")[0] != nil
            @map['TimedOut'] = element.get_elements("TimedOut")[0].get_text
          end
          
          if element.get_elements("DisplayText")[0] != nil
            @map['DisplayText'] = element.get_elements("DisplayText")[0].get_text
          end
          
          if element.get_elements("ReceiptText")[0] != nil
            @map['ReceiptText'] = element.get_elements("ReceiptText")[0].get_text
          end
          
          if element.get_elements("CardHolderName")[0] != nil
            @map['CardHolderName'] = element.get_elements("CardHolderName")[0].get_text
          end
          
          if element.get_elements("VoucherText")[0] != nil
            @map['VoucherText'] = element.get_elements("VoucherText")[0].get_text
          end
          
          if element.get_elements("VoucherType")[0] != nil
            @map['VoucherType'] = element.get_elements("VoucherType")[0].get_text
          end
          
          if element.get_elements("InitialAmount")[0] != nil
            @map['InitialAmount'] = element.get_elements("InitialAmount")[0].get_text
          end
          
          if element.get_elements("InitialBalance")[0] != nil
            @map['InitialBalance'] = element.get_elements("InitialBalance")[0].get_text
          end
          
          if element.get_elements("BatchNo")[0] != nil
            @map['BatchNo'] = element.get_elements("BatchNo")[0].get_text
          end
          
          if element.get_elements("CurrentBalance")[0] != nil
            @map['CurrentBalance'] = element.get_elements("CurrentBalance")[0].get_text
          end
          
          if element.get_elements("Benefit")[0] != nil
            @map['Benefit'] = element.get_elements("Benefit")[0].get_text
          end
          
          if element.get_elements("Language")[0] != nil
            @map['Language'] = element.get_elements("Language")[0].get_text
          end
          
          if element.get_elements("ErrorCode")[0] != nil
            @map['ErrorCode'] = element.get_elements("ErrorCode")[0].get_text
          end
          
          if element.get_elements("ErrorMessage")[0] != nil
            @map['ErrorMessage'] = element.get_elements("ErrorMessage")[0].get_text
          end

          if element.get_elements("ActivationCharge")[0] != nil
            @map['ActivationCharge'] = element.get_elements("ActivationCharge")[0].get_text
          end
          
          if element.get_elements("RemainingBalance")[0] != nil
            @map['RemainingBalance'] = element.get_elements("RemainingBalance")[0].get_text
          end
          
          if element.get_elements("CardStatus")[0] != nil
            @map['CardStatus'] = element.get_elements("CardStatus")[0].get_text
          end
          
          if element.get_elements("DataKey")[0] != nil
            @map['DataKey'] = element.get_elements("DataKey")[0].get_text
          end
          
          if element.get_elements("ResSuccess")[0] != nil
            @map['ResSuccess'] = element.get_elements("ResSuccess")[0].get_text
          end
          
          if element.get_elements("PaymentType")[0] != nil
            @map['PaymentType'] = element.get_elements("PaymentType")[0].get_text
          end
          
          if element.get_elements("CorporateCard")[0] != nil
            @map['CorporateCard'] = element.get_elements("CorporateCard")[0].get_text
          end

          
          if element.get_elements("BankTotals")[0] != nil
            banktotals = RespMod::Banktotals.new
            banktotals.from_xml(element.get_elements("BankTotals")[0])
            @map['BankTotals'] = banktotals
          end
          
          if element.get_elements("HostTotals")[0] != nil
            
           hosttotals = RespMod::HostTotals.new
           hosttotals.from_xml(element.get_elements("HostTotals")[0])
           @map['HostTotals'] = hosttotals
          end
       
          if element.get_elements("InitData")[0] != nil       
           initdata = RespMod::InitData.new
           initdata.from_xml(element.get_elements("InitData")[0])
           @map['InitData'] = initdata
         end
         
         resdatum = Array.new
          if element != nil
            if element.get_elements("ResolveData")[0] != nil
              0.upto(element.get_elements("ResolveData").length-1) do |x|
                resdata = RespMod::ResolveData.new
                resdata.from_xml(element.get_elements("ResolveData")[x])
                resdatum << resdata
              end
            end
          end
          @map['ResolveData'] = resdatum
         
      end
end

class Banktotals < Xml
        @@keys = ["ECR"]
        make_attrs(Banktotals,@@keys)

        def to_xml(indent="")
          to_xml_low("BankTotals",@@keys,indent)
        end
        
        def from_xml(element)
        
          ecr = RespMod::BTEcr.new
          ecr.from_xml(element.get_elements("ECR")[0])
          @map['ECR'] = ecr
        
        end
end

class BTEcr < Xml
        @@keys = ["term_id","closed","Card"]
        make_attrs(BTEcr,@@keys)

        def to_xml(indent="")
          to_xml_low("ECR",@@keys,indent)
        end
        
        def from_xml(element)
          
          if element != nil
  
            @map['term_id'] = element.get_elements("term_id")[0].get_text.value
            @map['closed'] = element.get_elements("closed")[0].get_text.value
          
            cards = Array.new
          
            card1 = RespMod::BTCard.new
            card1.from_xml(element.get_elements("Card")[0])
                    
            card2 = RespMod::BTCard.new
            card2.from_xml(element.get_elements("Card")[1])
          
          
            card3 = RespMod::BTCard.new
            card3.from_xml(element.get_elements("Card")[2])
          
            cards << card1 << card2 << card3
          
            @map['Card'] = cards
          end
        end
end

class BTCard < Xml
        @@keys = ["CardType","Purchase","Refund","Correction"]
        make_attrs(BTCard,@@keys)

        def to_xml(indent="")
                to_xml_low("Card",@@keys,indent)
        end
        
        def from_xml(element)
          
          if element != nil
            purchase = RespMod::Purchase.new
            purchase.from_xml(element.get_elements("Purchase")[0])
            @map['Purchase'] = purchase
        
            refund = RespMod::Refund.new
            refund.from_xml(element.get_elements("Refund")[0])
            @map['Refund'] = refund

            correction = RespMod::Correction.new
            correction.from_xml(element.get_elements("Correction")[0])
            @map['Correction'] = correction
          
          
            if element.get_elements("CardType")[0] !=nil
              @map['CardType'] = element.get_elements("CardType")[0].get_text.value
            end
          end
        end
        
end

class InitData < Xml
  @@keys = ["Card"]  
  make_attrs(InitData,@@keys)
 
  def to_xml(indent="")
    to_xml_low("InitData",@@keys,indent)
  end
 
  def from_xml(element)
    cards = Array.new
    if element != nil
      0.upto(element.get_elements("Card").length-1) do |x|
        card = RespMod::Card.new
        card.from_xml(element.get_elements("Card")[x])
        cards << card
      end
    end
    @map['Card'] = cards
  end
end

class HostTotals < Xml
        @@keys = ["ECR"]
        make_attrs(HostTotals,@@keys)

        def to_xml(indent="")
          to_xml_low("HostTotals",@@keys,indent)
        end
        
        def from_xml(element)
        
          ecr = RespMod::ECR.new
          ecr.from_xml(element.get_elements("ECR")[0])
          @map['ECR'] = ecr
        
        end
end


class ECR < Xml
  @@keys = ["term_id","closed","Card"]  
  make_attrs(ECR,@@keys)
 
  def to_xml(indent="")
    to_xml_low("ECR",@@keys,indent)
  end
 
  def from_xml(element)
    
    if element != nil
        
      if element.get_elements("term_id")[0] !=nil
        @map['term_id'] = element.get_elements("term_id")[0].get_text
      end
      if element.get_elements("closed")[0] !=nil
        @map['closed'] = element.get_elements("closed")[0].get_text
      end
      
      cards = Array.new
      
      0.upto(element.get_elements("Card").length-1) do |x|
        card = RespMod::BatchCards.new
        card.from_xml(element.get_elements("Card")[x])
        cards << card
      end
    end
    @map['Card'] = cards
  end
end

class Card < Xml
        @@keys = ["CardCode","CardCardType","CheckMod10","CheckLanguage","CVCPrompt",
        "InfoPrompt","InitialAmountPrompt","RefundAllowed","CardLengthMinimum",
        "CardLengthMaximum","LowBIN1","HighBIN1","LowBIN2","HighBIN2","LowBIN3",
        "HighBIN3","LowBIN4","HighBIN4","Text"]
        make_attrs(Card,@@keys)

        def to_xml(indent="")
          to_xml_low("Card",@@keys,indent)
        end
        
        def from_xml(element)
          
          if element != nil
  
            @map['CardCode'] = element.get_elements("CardCode")[0].get_text
            @map['CardCardType'] = element.get_elements("CardType")[0].get_text
            @map['CheckMod10'] = element.get_elements("CheckMod10")[0].get_text
            @map['CheckLanguage'] = element.get_elements("CheckLanguage")[0].get_text
            @map['CVCPrompt'] = element.get_elements("CVCPrompt")[0].get_text       
            @map['InfoPrompt'] = element.get_elements("InfoPrompt")[0].get_text
            @map['InitialAmountPrompt'] = element.get_elements("InitialAmountPrompt")[0].get_text
            @map['RefundAllowed'] = element.get_elements("RefundAllowed")[0].get_text            
            @map['CardLengthMinimum'] = element.get_elements("CardLengthMinimum")[0].get_text
            @map['CardLengthMaximum'] = element.get_elements("CardLengthMaximum")[0].get_text
            @map['LowBIN1'] = element.get_elements("LowBIN1")[0].get_text           
            @map['HighBIN1'] = element.get_elements("HighBIN1")[0].get_text
            @map['LowBIN2'] = element.get_elements("LowBIN2")[0].get_text
            @map['HighBIN2'] = element.get_elements("HighBIN2")[0].get_text
            @map['LowBIN3'] = element.get_elements("LowBIN3")[0].get_text
            @map['HighBIN3'] = element.get_elements("HighBIN3")[0].get_text
            @map['LowBIN4'] = element.get_elements("LowBIN4")[0].get_text
            @map['HighBIN4'] = element.get_elements("HighBIN4")[0].get_text
            
            texts = Array.new
            0.upto(element.get_elements("Text").length-1) do |y|
              text = RespMod::Text.new
              text.from_xml(element.get_elements("Text")[y])
              texts << text
            end
            @map['Text'] = texts
          end
        end
end

class Text < Xml
        @@keys = ["RecordType","CardDescription","InfoPromptText"]
        make_attrs(Text,@@keys)

        def to_xml(indent="")
          to_xml_low("Text",@@keys,indent)
        end
        
        def from_xml(element)
            if element.get_elements("RecordType")[0] !=nil
              @map['RecordType'] = element.get_elements("RecordType")[0].get_text
            end
            if element.get_elements("CardDescription")[0] !=nil
              @map['CardDescription'] = element.get_elements("CardDescription")[0].get_text
            end
            if element.get_elements("BenefitDescription")[0] !=nil
              @map['BenefitDescription'] = element.get_elements("BenefitDescription")[0].get_text
            end
            if element.get_elements("BenefitPromptText")[0] !=nil
              @map['BenefitPromptText'] = element.get_elements("BenefitPromptText")[0].get_text
            end
            if element.get_elements("AmountPromptText")[0] !=nil
              @map['AmountPromptText'] = element.get_elements("AmountPromptText")[0].get_text
            end
            if element.get_elements("InfoPromptText")[0] !=nil
              @map['InfoPromptText'] = element.get_elements("InfoPromptText")[0].get_text
            end
            if element.get_elements("TotalsDescription")[0] !=nil
              @map['TotalsDescription'] = element.get_elements("TotalsDescription")[0].get_text
            end
        end
end

class BatchCards < Xml
        @@keys = ["CardCode","PurchaseCount","PurchaseTotal","PurchaseBenefitTotal",
        "RefundCount","RefundTotal","RefundBenefitTotal",
        "RedemptionCount","RedemptionTotal","RedemptionBenefitTotal",
        "ActivationCount","ActivationTotal","CorrectionCount","CorrectionTotal"]
        make_attrs(BatchCards,@@keys)

        def to_xml(indent="")
          to_xml_low("Card",@@keys,indent)
        end
        
        def from_xml(element)
          
          if element != nil
  
            @map['CardCode'] = element.get_elements("CardCode")[0].get_text
            @map['PurchaseCount'] = element.get_elements("PurchaseCount")[0].get_text
            @map['PurchaseTotal'] = element.get_elements("PurchaseTotal")[0].get_text
            @map['PurchaseBenefitTotal'] = element.get_elements("PurchaseBenefitTotal")[0].get_text
            @map['RefundCount'] = element.get_elements("RefundCount")[0].get_text
            @map['RefundTotal'] = element.get_elements("RefundTotal")[0].get_text
            @map['RefundBenefitTotal'] = element.get_elements("RefundBenefitTotal")[0].get_text
            @map['RedemptionCount'] = element.get_elements("RedemptionCount")[0].get_text
            @map['RedemptionTotal'] = element.get_elements("RedemptionTotal")[0].get_text
            @map['RedemptionBenefitTotal'] = element.get_elements("RedemptionBenefitTotal")[0].get_text
            @map['ActivationCount'] = element.get_elements("ActivationCount")[0].get_text
            @map['ActivationTotal'] = element.get_elements("ActivationTotal")[0].get_text            
            @map['CorrectionCount'] = element.get_elements("CorrectionCount")[0].get_text
            @map['CorrectionTotal'] = element.get_elements("CorrectionTotal")[0].get_text            
            
          end
        end
end

class Purchase < Xml
        @@keys = ["Count","Amount"]
        make_attrs(Purchase,@@keys)

        def to_xml(indent="")
                to_xml_low("Purchase",@@keys,indent)
        end
        
        def from_xml(element)
          if element !=nil
            @map['Count'] = element.get_elements("Count")[0].get_text.value
            @map['Amount'] = element.get_elements("Amount")[0].get_text.value
          end
        end
end

class Refund < Xml
        @@keys = ["Count","Amount"]
        make_attrs(Refund,@@keys)

        def to_xml(indent="")
                to_xml_low("Refund",@@keys,indent)
        end
        
        def from_xml(element)
          if element !=nil
            @map['Count'] = element.get_elements("Count")[0].get_text.value
            @map['Amount'] = element.get_elements("Amount")[0].get_text.value
          end
        end
end

class Correction < Xml
        @@keys = ["Count","Amount"]
        make_attrs(Correction,@@keys)

        def to_xml(indent="")
                to_xml_low("Correction",@@keys,indent)
        end
        
        def from_xml(element)
          if element !=nil
            @map['Count'] = element.get_elements("Count")[0].get_text.value
            @map['Amount'] = element.get_elements("Amount")[0].get_text.value
          end
        end
end

class ResolveData < Xml
        @@keys = ["cust_id","phone","email","note","masked_pan","pan","expdate","crypt_type",
        "avs_street_number","avs_street_name","avs_zipcode","payment_type","data_key"]
        make_attrs(ResolveData,@@keys)

        def to_xml(indent="")
                to_xml_low("ResolveData",@@keys,indent)
        end
        
        def from_xml(element)
          if element !=nil
            if element.get_elements("cust_id")[0] != nil
              @map['cust_id'] = element.get_elements("cust_id")[0].get_text
            end              
            if element.get_elements("phone")[0] != nil
              @map['phone'] = element.get_elements("phone")[0].get_text
            end
            if element.get_elements("email")[0] != nil              
              @map['email'] = element.get_elements("email")[0].get_text
            end
            if element.get_elements("note")[0] != nil
              @map['note'] = element.get_elements("note")[0].get_text            
            end
            if element.get_elements("pan")[0] != nil
              @map['pan'] = element.get_elements("pan")[0].get_text            
            end
            if element.get_elements("masked_pan")[0] != nil
              @map['masked_pan'] = element.get_elements("masked_pan")[0].get_text            
            end
            if element.get_elements("expdate")[0] != nil
              @map['expdate'] = element.get_elements("expdate")[0].get_text            
            end
            if element.get_elements("crypt_type")[0] != nil
              @map['crypt_type'] = element.get_elements("crypt_type")[0].get_text            
            end
            if element.get_elements("avs_street_number")[0] != nil
              @map['avs_street_number'] = element.get_elements("avs_street_number")[0].get_text            
            end
            if element.get_elements("avs_street_name")[0] != nil
              @map['avs_street_name'] = element.get_elements("avs_street_name")[0].get_text            
            end
            if element.get_elements("avs_zipcode")[0] != nil
              @map['avs_zipcode'] = element.get_elements("avs_zipcode")[0].get_text            
            end
            if element.get_elements("data_key")[0] != nil
              @map['data_key'] = element.get_elements("data_key")[0].get_text            
            end
            if element.get_elements("payment_type")[0] != nil
              @map['payment_type'] = element.get_elements("payment_type")[0].get_text            
            end
          end
        end
end

end
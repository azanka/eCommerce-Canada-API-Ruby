require 'net/https'
require 'uri'
require_relative '../../eSELECTplus_Ruby_API_v252/eSELECTplus_Ruby_API_v252/xml.rb'
require 'rexml/document'

class MpiHttpsPoster

        @@uri = URI.parse("https://esqa.moneris.com")

        def MpiHttpsPoster.post(mpi_request)
                http = Net::HTTP.new(@@uri.host,@@uri.port)
                http.use_ssl = true
								http.verify_mode = OpenSSL::SSL::VERIFY_PEER

                puts "Sending:\n#{mpi_request.to_xml}"

								mpiresponse = Mpiresponse.new

                http.start {
                        http.request_post("/mpi/servlet/MpiServlet",mpi_request.to_xml, {'User-Agent' => 'Ruby (v1.2.0)'}) {|res|
                                mpiresponse.from_xml(res.body)
                        }
                }
								return mpiresponse
        end
end
################### Request #####################
class Mpirequest < Xml
        @@keys = ["store_id","api_token","txn","acs"]
        make_attrs(Mpirequest,@@keys)

        def to_xml(indent="")
                to_xml_low("MpiRequest",@@keys,indent)
        end
end

class Txn < Xml
        @@keys = ["xid","amount","pan","expdate","MD","merchantUrl","accept","userAgent","recurFreq","recurEnd","install"]
        make_attrs(Txn,@@keys)

        def to_xml(indent="")
                to_xml_low("txn",@@keys,indent)
        end
end

class Acs < Xml
        @@keys = ["PaRes","MD"]
        make_attrs(Acs,@@keys)

        def to_xml(indent="")
                to_xml_low("acs",@@keys,indent)
        end
end

##################### Response ###########################
class Mpiresponse < Xml
        @@keys = ["type","success","message","PaReq","TermUrl","MD","ACSUrl","cavv","PAResVerified"]
        make_attrs(Mpiresponse,@@keys)

        def to_xml(indent="")
                to_xml_low("MpiResponse",@@keys,indent)
        end

				def from_xml(element)
					doc = REXML::Document.new(element)
#					receipt = RespMod::Receipt.new
#					receipt.from_xml(doc.root().get_elements("receipt")[0])
#					@map['receipt'] = receipt
#					Mpiresponse.from_xml(doc.root().get_elements("MpiResponse")[0])

					@map['type'] = doc.root().get_elements("type")[0].get_text.value
					@map['success'] = doc.root().get_elements("success")[0].get_text.value
					@map['message'] = doc.root().get_elements("message")[0].get_text.value
					@map['PaReq'] = doc.root().get_elements("PaReq")[0].get_text.value
					@map['TermUrl'] = doc.root().get_elements("TermUrl")[0].get_text.value
					@map['MD'] = doc.root().get_elements("MD")[0].get_text.value
					@map['ACSUrl'] = doc.root().get_elements("ACSUrl")[0].get_text.value
					@map['cavv'] = doc.root().get_elements("cavv")[0].get_text.value
					@map['PAResVerified'] = doc.root().get_elements("PAResVerified")[0].get_text.value

				end
end

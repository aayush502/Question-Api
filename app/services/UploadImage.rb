require "singleton"

class UploadImage
  include Singleton

  def get_schema_image_url
    image_token = SchemaRegister.find_by(subdomain: Apartment::Tenant.current)&.image_token

    image_name = Image.find_by(image_token: image_token)&.image_name

    if image_name.nil?
      ""
    else
      "https://storage.googleapis.com/thump_image/" + image_name
    end
  end

  def uploadImage(image)
    require "httparty"

    postRequest = HTTParty.post("http://165.22.215.229:3080/save_image",
                                body: {

                                  "axiosToken": "asos@123$%^",

                                  "axioscloud_project": "dabali_store",

                                  "axioscloud_image": image,

                                })

    postRequest.parsed_response["image_token"]
  end

  def upload_base64_image(base64_image)
    require "httparty"

    postRequest = HTTParty.post("http://165.22.215.229:3080/save_base64_image",
                                body: {

                                  "axiosToken": "asos@123$%^",

                                  "axioscloud_project": "dabali_store",

                                  "axioscloud_image": base64_image,

                                })

    postRequest.parsed_response["image_token"]
  end

  def getImageLink(image_token)
    if image_token.nil?
      ""
    else
      "https://storage.googleapis.com/dabali_store/" + image_token
    end
  end

  def getThumpImageLink(image_token)
    if image_token.nil?
      ""
    else
      "https://storage.googleapis.com/thump_image/" + image_token
    end
  end

  def deleteImage(image)
    require "httparty"

    postRequest = HTTParty.post("http://165.22.215.229:3080/remove_object",
                                body: {

                                  "axiosToken": "asos@123$%^",

                                  "axioscloud_project": "dabali_store",

                                  "axioscloud_image": image,

                                })
  end
end

require "json"
# require "ibm_watson"
require "ibm_watson/language_translator_v3"
include IBMWatson


class PostsController < ApplicationController
  def create
  end

  def update
  end

  def index
  end

  def show
  end

  def destroy
  end

  private


  def init_translator
    creds = {
      "apikey": "lgEFBcnLjSPMPOlr9ODPXSnPHxkUJvBgRERzWJO6NqkP",
      "iam_apikey_description": "Auto-generated for key f9ccb07f-0f5c-4aad-8cac-51b950b33b87",
      "iam_apikey_name": "Auto-generated service credentials",
      "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
      "iam_serviceid_crn": "crn:v1:bluemix:public:iam-identity::a/b1fa3cfa5c264217937928799c865aa1::serviceid:ServiceId-8c720031-320e-4958-9138-9278cc3a9f3c",
      "url": "https://gateway-tok.watsonplatform.net/language-translator/api"
    }
    language_translator = IBMWatson::LanguageTranslatorV3.new(
      version: "2018-05-01",
      iam_apikey: creds[:apikey],
      url: creds[:url]
    )
    return language_translator
  end

  def identify_language(string)
    # Identifies the language when given a string; returns language code like "en" or "zh" etc.

    language = init_translator.identify(
      text: string
    )
    return language.result["languages"][0]["language"]
  end

  def translate_string(source, target, string)
    # Translates string when given the source and target language codes

    translation = init_translator.translate(
      text: string,
      model_id: "#{source}-#{target}"
    )
    return translation.result["translations"][0]["translation"]
  end
end

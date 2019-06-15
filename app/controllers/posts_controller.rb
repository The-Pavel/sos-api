class PostsController < ApplicationController
  require "json"
  require "open-uri"
  require "ibm_watson/language_translator_v3"
  include IBMWatson

  before_action :set_post, only: [ :add_comment, :show, :update, :destroy ]
  skip_before_action :verify_authenticity_token

  def create
    @post = Post.new(post_params)

    @post.language = identify_language(@post.description)
    if @post.save
      render :show, status: :created
      #AMAP save post lat/long
      addr = @post.location
      address_encode = URI.encode("#{addr}output=JSON&key=27df61d7d7a623d9d3ef412a48ee6218")
      url = "https://restapi.amap.com/v3/geocode/geo?address=#{address_encode}"
      serialize = open(url).read
      parse = JSON.parse(serialize)
      location = parse["geocodes"][0]["location"].split(",")
      @post.update lat: location[1]
      @post.update long: location[0]
    else
      render_error
    end
  end

  def update
    if @post.update(post_params)
      render :show
    else
      render_error
    end
  end

  def index
    # getting language from url query
    user_language = params[:lang]
    # filtering posts from last 10 days
    posts = Post.all.where('created_at >= ?', 10.days.ago)
    @posts = []
    posts.each do |post|
      # checking posts language vs user language
      unless post.language == user_language
        post.description = translate_string(post.language, user_language, post.description)
      end
      @posts << post
    end
  end

  def show
  end

  def destroy
    @post.destroy
    head :no_content
  end

  def add_comment
    @comment = Comment.new(nickname: User.find(comment_params[:user_id]).nickname, comment: comment_params[:comment], post: Post.find(comment_params[:post_id]))
    if @comment.save
      render :index
    else
      render :json => { :errors => @comment.errors.full_messages }
    end
  end

  private

  def set_post
    @post = Post.find(post_params[:id])
  end

  def post_params
    if params[:post].present?
      params.require(:post).permit(:user_id, :description, :capacity, :location, :language, :contact_number, :is_full, :id, :lat, :long)
    else
      params.permit(:id)
    end
  end


  def comment_params
    params.require(:comment).permit(:comment, :post_id, :language, :user_id)
  end

  def init_translator
    # returns an instance of the Watson translator


#IBM LANGUAGE TRANSLATOR
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

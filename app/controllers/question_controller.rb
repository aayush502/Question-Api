class QuestionController < ApplicationController
  skip_before_action :verify_authenticity_token

  def save_question
    question = Question.new
    question.Qustion = params[:question][:question]
    question.token = params[:question][:token]
    question.picture_token = UploadImage.instance.upload_base64_image(params[:question][:picture_token])
    question.save!

    params[:question_detail].each do |item|
      question_detail = QuestionDetail.new
      question_detail.question_token = question.id
      question_detail.x1 = item["x1"]
      question_detail.y1 = item["y1"]
      question_detail.x2 = item["x2"]
      question_detail.y2 = item["y2"]
      question_detail.value = item["value"]
      question_detail.save!
    end
  end

  def get_question
    @questions = Question.select("id", "Qustion", "picture_token").where(token: params[:token]).as_json

    @questions.each do |item|
      item["question_data"] = QuestionDetail.select("x1", "y1", "x2", "y2").where(question_token: item["id"]).as_json
      # all_question = all_question + QuestionDetail.select("id", "x1", "y1", "x2", "y2").where(question_token: item[:id]).as_json
      # all_values = all_values + QuestionDetail.select("value").where(question_token: item[:id]).as_json
    end
    # @values = QuestionDetail.select("value").where(question_token: @questions[0]["id"])
    # data = [@questions + all_question + all_values]
    render json: { "data" => @questions }
  end

  def executeRawQuery(query)
    return ActiveRecord::Base.connection.execute(query)
  end

  def get_answer
    @questions = Question.select("id", "Qustion", "picture_token").where(token: params[:token]).as_json

    @questions.each do |item|
      item["question_data"] = QuestionDetail.select("x1", "y1", "x2", "y2").where(question_token: item["id"]).as_json
      item["values"] = QuestionDetail.select("value").where(question_token: item["id"]).as_json
    end

    # @values = executeRawQuery("select q.token,array_agg(qd.value) as values from questions q left join question_details qd on qd.question_token=q.id where q.token=5 group by q.token")[0]["values"]

    # data = Hash.new
    # data["question"] = @questions
    # data["values"] = @values
    # render json: data
    render json: { "data" => @questions }
  end
end

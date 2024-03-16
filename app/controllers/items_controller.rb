require 'line_notify'  # LineNotifyモジュールをロード
  # require 'net/http'

class ItemsController < ApplicationController
  before_action :set_user

  def new
    @item = @user.items.new
  end

  def create
    @item = @user.items.new(item_params)
    if @item.save(validate: false)
      @item.update(status: '登録済み')
      redirect_to user_path(@user), notice: '商品登録が完了しました。'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @item = Item.find(params[:id])
    
  end

  def update
    @item = @user.items.find(params[:id])
    if @item.update(item_params)
      @item.update(status: '未手配')
      redirect_to user_path(@user), notice: '配送先の登録が完了しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def copy
    # コピー処理を実装してください
  end
  
  def mark_as_arranged
    @item = Item.find(params[:id])
    @item.update(status: '手配済み')
    redirect_to user_items_path(@user), notice: '配送手配が完了しました。'
  end
  
  def request_arrange
    @item = Item.find(params[:id])
    if @item.status == "未手配"
      message = "新しいアイテムが登録されました。\n"
      message += "ユーザー名: #{@user.name}\n"
      message += "商品名: #{@item.item_name}"
      LineNotify.post_message(message)
      @item.update(status: '依頼中')
      redirect_to user_path(@user), notice: 'アイテムの配送手配を依頼しました'
    else
      redirect_to user_path(@user), alert: 'このアイテムはすでに手配済みです'
    end
  end
  
  
  def search
    # フォームで送られたパラメータを取得する
    if postal_code = params[:postal_code]
      # ここでエンコードする。URI.encode_www_formメソッドで、URLの末尾に「zipcode=郵便番号」を作っている
      params = URI.encode_www_form({zipcode: postal_code})
      # これでURLを取得する、paramsは変数なので展開する必要あり
      uri = URI.parse("https://zipcloud.ibsnet.co.jp/api/search?#{params}")
      # レスポンスを取得している、GET![スクリーンショット 2020-12-18 23.46.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/431899/9b912f6a-f11b-5065-73e6-909459901403.png)

      response = Net::HTTP.get_response(uri)
      # JSON形式に変換
      if result = JSON.parse(response.body)
        #viewで使用するために、インスタンス変数に格納
        #レスポンスで、都道府県名や、市区町村を指定して取得する
        @zipcode = result["results"][0]["zipcode"]
        @address1 = result["results"][0]["address1"]
        @address2 = result["results"][0]["address2"]
        @address3 = result["results"][0]["address3"]
      end
    end
  end
  

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def item_params
    params.require(:item).permit(:buyer,:item_name, :zipcode, :address1, :address2, :address3, :banchi, :tatemono_name, :room_num, :tel)
  end
end

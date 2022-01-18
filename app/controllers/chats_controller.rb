class ChatsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    rooms = current_user.user_rooms.pluck(:room_id)
    # 相手のroom_idをuser_roomカラムから探し配列で取りだす
    # user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    # # 自分と相手のユーザールーム(チャットの存在)をさがす

    # # メッセージが存在する場合
    # if user_rooms.nil?
    #   @room = Room.new
    #   @room.save
    # else
    #   @room = user_rooms.room
    # end

    @chats = Chat.where(user_id: @user.id, sender: current_user.id).or(Chat.where(user_id: current_user.id, sender: @user.id))
    @chat = Chat.new
  end

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    # 相手のroom_idをuser_roomカラムから探し配列で取りだす
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    # 自分と相手のユーザールーム(チャットの存在)をさがす

    # メッセージが存在する場合
    if user_rooms.nil?
      @room = Room.new
      @room.save
    else
      @room = user_rooms.room
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = Chat.new(chat_params)
    @user = User.find(params[:chat][:user_id])
    @chat.user_id = @user.id
    @chat.sender = current_user.id
    if @chat.save
      redirect_to chats_path(user_id: @user.id)
    else
    end
    # 相手のroom_idをuser_roomカラムから探し配列で取りだす
    # user_rooms = UserRoom.find_by(user_id: current_user.id, room_id: rooms)
    # 自分と相手のユーザールーム(チャットの存在)をさがす

     # メッセージが存在する/しない場合
    # if user_rooms.nil?
    #   @room = Room.new
    #   @room.save
    #   # 2人のユーザールームを作る
    #   # 自分と相手のuserroomモデルにレコードを保存
    #   UserRoom.create(user_id: @user.id, room_id: @room.id)
    #   UserRoom.create(user_id: current_user.id, room_id: @room.id)
    # else
    #   @room = user_rooms.room
    # end

    # @chats = @room.chats
    # @chat = Chat.new(room_id: @room.id)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
    # hidden_fieldでのroom_idを受け取る
  end

end

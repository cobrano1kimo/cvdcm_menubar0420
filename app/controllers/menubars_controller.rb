class MenubarsController < ApplicationController
  before_action :find_menubar, only: [:form, :edit, :update, :destroy]
  before_action :find_parent_menubar, only: [:create]

  attr_accessor :current_menu_id

  def index
    @form_state  = 'browse'
    @menubars = Menubar.page(params[:page]).per(10)
    @menubar = @menubars.first
    @menus = Menubar.order(:menu_sn)
    if @current_page != params[:page] || @current_menu_id.blank? then
      @current_menu_id = @menubar.menu_id
      @current_page = params[:page]
    end
    # respond_to do |format|
    #   format.html
    #   format.json
    #   format.js
    # end
  end

  def form
    # @current_menu_id = params[:menu_id]
    render partial: "form", locals: { form_state: @form_state}
    # render partial: "form", locals: {menubar: @menubar}
    # respond_to do |format|
    #   format.html
    #   format.json
    #   format.js
    # end
  end

  def show
    @form_state  = 'browse'
    @menubars = Menubar.page(params[:page]).per(10)
  end

  # 顯示系統選單項目
  def show_menu
    @menus = Menubar.order(:menu_sn)
  end

  def new
    @form_state  = 'new'
    # @current_menu_id = @menubar.menu_id
    # @current_menu_id =  cookies[:current_menu_id]
    # cookies[:current_menu_id] = { value: @menubar.menu_id, expires: 1.hour.from_now }
    @menubar = Menubar.new
  end

  def create
    @menubar = Menubar.create(menubar_params)

    respond_to do |format|
      if @menubar.save
        format.js { j render 'create.js.erb' }
        format.json { head :no_content }
        # format.html { head :no_content }
      else
        format.js
        format.json { render json: @menubar.errors.full_messages,
                           status: :unprocessable_entity}
        # format.html
        # render :new
      end
    end
    # @current_menu_id = @menubar.menu_id

    # if @menubar.save
    #   # 成功
    #   redirect_to menubars_path, notice: "新增選單成功！"
    # else
    #   # 失敗
    #   render :new
    # end
  end

  def edit
    @form_state  = 'edit'
    @current_menu_id = params[:menu_id]
    # cookies[:current_menu_id] = { value: @current_menu_id, expires: 1.hour.from_now }
    if params[:menu_id].present?
      @menubar = Menubar.find_by(menu_id: params[:menu_id])
    else
      @menubar = Menubar.first
    end
    # render partial: 'menubars/menubar_form'
    # render partial: 'form'
  end


  def update
    #@menubar = Menubar.find(params[:menu_id])
    respond_to do |format|
      if @menubar.update_with_conflict_validation(menubar_params)
      # if @menubar.update(menubar_params)
        format.js { j render 'update.js.erb' }
        # format.html { redirect_to menubars_path }
        format.json { head :no_content }
      # else
        # format.html { render partial: 'form' }
        # format.json { render json: @product.errors, status: :unprocessable_entity }
      else
        format.js
        format.json { render json: @menubar.errors.full_messages, status: :unprocessable_entity}
        # redirect_to form_menubar_path(@current_menu_id)
      end
    end

  # rescue ActiveRecord::StaleObjectError
    # render :conflict
  end

  def destroy
    @form_state  = 'destroy'
    # render plain: params[:menu_id]
    @menubar.destroy if @menubar
    respond_to do |format|
      format.js {render inline: "location.reload();" }
      # format.js { j render 'delete.js.erb' }
      format.json { head :no_content }
    end
    form_menubar_path()
    # cookies.delete :current_menu_id
  end

  def reset
    @form_state  = 'browse'
    respond_to do |format|
      format.js { j render 'reset.js.erb' }
      format.json { head :no_content }
    end
  end

  def search
    # @form_state  = 'search'
    # respond_to do |format|
    #   format.js { j render 'search.js.erb' }
    #   format.json { head :no_content }
    # end
  end

  private
  def menubar_params
    params.require(:menubar).permit(:menu_id, :menu_name, :parent_menu_id,
                                    :menu_sn, :program_id, :program_url,
                                    :lock_version)
  end

  def find_menubar
    @menubar = Menubar.find(params[:menu_id])
    # @current_menu_id = @menubar.menu_id
  end

  def find_parent_menubar
    @parent_menu = Menubar.select("menu_id, menu_name").where.not(parent_menu_id: '').order(:parent_menu_id)
  end

end

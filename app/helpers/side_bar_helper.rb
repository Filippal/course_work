module SideBarHelper
  def side_bar_items(ru)
    result = []
    result << {
      :name => 'На главную',
      :icon => 'list',
      :controller => :welcome,
      :action => :index
    }
    result << {
      :name => 'Администрирование',
      :icon => 'users',
      :children => [
      {:name => 'Пользователи',
       :controller => :users, :action => :index,
       :icon => 'users',
       :class => 'long'},
      {:name => 'Добавление',
       :controller => :users, :action => :new,
       :icon => 'user-plus'},
      {:name => 'Роли',
       :controller => :roles, :action => :index,
       :icon => 'align-center',
       :class => 'long'},
    ]}
    result << {
      :name => 'Поваренная книга',
      :icon => 'book',
      :children => [
      {:name => 'Поиск',
        :controller => :dishes, :action => :search,
        :icon => 'search'},
      {:name => 'Категории блюд',
       :controller => :dish_categories, :action => :index,
       :icon => 'search'},
      {:name => 'Блюда',
       :controller => :dishes, :action => :index,
       :icon => 'cutlery',
       :class => 'long'}
    ]}
    result
  end

  def is_open?(ctr, act)
    case ctr.to_s
    when 'users', 'roles'
      ctr.to_s == controller_name.to_s
    else
      false
    end
  end
end

# Day 7

### 간단과제

#### ASK 만들기

- `ask` 모델과 `ask_controller`를 만듭니다.

> ask 모델의 column
>
> - ip_address
> - region
> - question

- `/ask` : 나에게 등록된 모든 질문을 출력 
- `/ask/new` : 새로운 질문을 작성하는 곳

```command
$ rails g model ask
$ rails g controller ask
```



#### Index, New, Show

*db/migrate/create_asks.rb*

```ruby
class CreateAsks < ActiveRecord::Migration[5.0]
  def change
    create_table :asks do |t|
      t.text "question"  # 질문을 저장할 question 이라는 컬럼을 지정해줌
      t.timestamps
    end
  end
end

```

*config/routes.rb*

```ruby
...
get '/ask' => 'ask#index'
get '/ask/new' => 'ask#new'
post '/ask/create' => 'ask#create'
...
```

- 전체 목록을 보는 `/ask`액션과 새로운 질문을 등록하는 `/ask/new`, 실제로 글이 저장되는 `/ask/create` 까지 만들어줌

*app/controllers/ask_controller.rb*

```ruby
def index
    @asks = Ask.all
end

def new
end

def create
    ask = Ask.new
    ask.question = params[:q]
    ask.save
    redirect_to "/ask"
end
```

- 인덱스에서는 모든 질문을 보여주기 위해서 `.all` 메소드로 해당 테이블에 있는 모든 내용물을 불러 올 수 있다. 이는 Rails에 내장되어있는 ORM인 ActiveRecord가 가지고 있는 메소드 덕분인데, DB의 테이블 조작을 SQL로 하는 것이 아니라 루비 문법으로 조작할 수 있게 해주는 기능이다.

*app/views/ask/index.html.erb*

```erb
<a href="/ask/new">새 질문 등록하기</a>

<ul>
    <% @asks.reverse.each do |ask| %>
        <li><%= ask.question %></li>
    <% end %>
</ul>
```

- 상단에는 새 글을 등록할 수 있는 버튼이 있고 아래에는 저장된 질문 목록을 볼 수 있다.
- 지금 전체적으로 view가 못생겼다.. 아무런 css 를 추가하지 않았기 때문인데 bootstrap이라는 좋은 css, js 라이브러리를 활용하여 더 아름답게 만들어보자.

*Gemfile*

```ruby
gem 'bootstrap', '~> 4.1.1'
```

```command
$ bundle install
```

- bootstrap은 최근에 4버전으로 업데이트 되면서 Gem도 업데이트 됐다. 기존의 3버전을 쓰기 위해서는 `bootstrap` Gem 대신에 `gem 'bootstrap-sass'`를 설치해야 한다.

*app/assets/javascripts/application.js*

```js
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require turbolinks
//= require_tree .
```

*app/assets/stylesheets/application.scss*

```scss
@import "bootstrap";
```

> 기존에 css 파일은 확장자가 `.css` 인데 파일명 수정으로 `.scss`로 바꿔줘야 한다.

- 이렇게 하면 bootstrap 4 버전을 사용할 수 있다. class 속성을 주는 것만으로 view를 아름답게 할 수 있다.

*app/views/ask/index.html.erb*

```erb
<div class="text-center">
    <a class="btn btn-primary" href="/ask/new">새 질문 등록하기</a>
</div>
<ul class="list-group">
    <% @asks.reverse.each do |ask| %>
    <li class="list-group-item">
        <%= ask.question %>
    <% end %>
</ul>
```

*app/views/layouts/application.html.erb*

```erb
<!DOCTYPE html>
<html>
  <head>
    <title>TestApp</title>
    <%= csrf_meta_tags %>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom box-shadow">
      <h5 class="my-0 mr-md-auto font-weight-normal">나에게 질문하기</h5>
      <nav class="my-2 my-md-0 mr-md-3">
        <a class="p-2 text-dark" href="/ask">홈으로</a>
        <a class="p-2 text-dark" href="/ask/new">질문하기</a>
      </nav>
    </div>
    <div class="container">
    <%= yield %>
    </div>
  </body>
</html>

```

- nav바와 내용물을 가운데로 몰아주는 `container` 속성을 추가했다.

#### Delete

- CRUD 중에서 D는 Delete 혹은 Destroy, 삭제를 의미한다.
- 삭제하는 로직은 단순하다. 찾아서 삭제하고 다시 원래 페이지로 돌아가면 된다.

*config/routes.rb*

```ruby
...
  get '/ask/:id/delete' => 'ask#delete'
...
```

- RESTful 하게 구현하려면 http method 중에서 `delete` 방식을 사용해야하지만 지금은 `get` 방식으로 처리한다.

*app/controllers/ask_controller.rb*

```ruby
...
def delete
    ask = Ask.find(params[:id])
    ask.destroy
    redirect_to "/ask"
end
...
```

- 첫줄은 해당 row를 id로 검색해서 `ask`라는 변수에 담고, `ask.destroy`를 통해 삭제하고 원래의 페이지로 리디렉션을 걸어준다.

```erb
...
<ul class="list-group">
    <% @asks.reverse.each do |ask| %>
    <li class="list-group-item">
        <%= ask.question %>
        <a data-confirm="이 글을 삭제하시겠습니까?" class="btn btn-danger" href="/ask/<%= ask.id %>/delete">삭제</a></li>
    <% end %>
</ul>
```

- html 속성 중에서 `data-confirm`이라는 속성은 js코드를 쓰지 않고 `confirm`을 이용할 수 있다. `alert`는 안된다.



#### Edit, Update

- 수정 로직도 간단하다. 찾고 데이터를 바꾸고 저장하고, 원래의 페이지로 돌아간다. 다만 사용자에게 수정하는 페이지를 주기 위한 `edit` 액션에도 수정하기 전의 데이터를 보여주기 위해서 찾는 로직이 포함된다.

*config/routes.rb*

```ruby
...
  get'/ask/:id/edit' => 'ask#edit'
  post '/ask/:id/update' => 'ask#update'
...
```

*app/controllers/ask_controller.rb*

```ruby
...   
def edit
    @ask = Ask.find(params[:id])
end

def update
    ask = Ask.find(params[:id])
    ask.question = params[:q]
    ask.save
    redirect_to '/ask'
end
...
```

- `edit` 액션에서도 params로 넘어온 id로 검색해서 table에서 해당 row를 검색하여 `@ask` 변수에 넣어 사용한다. 마찬가지로 서버와 클라이언트의 connection은 req, res 한번에 끊기기 때문에 다음 `update` 액션에도 id를 넘겨서 검색하고 수정하고 저장하는 로직이 포함되어야 한다.



#### 사용자의 IP와 Geocoder

- 작은 재미를 위해 이 사이트를 사용하는 사용자의 ip와 사용자가 있는 도시의 이름을 저장하는 코드를 추가했다.

*Gemfile*

```ruby
...
  gem 'geocoder'
...
```

```command
$ bundle install
```

*db/migrate/create_asks.rb*

```ruby
class CreateAsks < ActiveRecord::Migration[5.0]
  def change
    create_table :asks do |t|
      
      t.text "question"
      t.string "ip_address"
      t.string "region"

      t.timestamps
    end
  end
end

```

*app/controllers/ask_controller.rb*

```ruby
...
def create
    ask = Ask.new
    ask.question = params[:q]
    ask.ip_address = request.ip
    ask.region = request.location.region
    ask.save
    redirect_to "/ask"
end
...
```

- 실제 DB에 저장될 때 요청이 온 ip를 저장하면 사용자의 ip와 ip를 기반으로 한 사용자의 위치까지 저장할 수 있다.



#### 특이사항

- 다음주 과제가 혼자서 **twitter app** 구현하기 인데 새로운 프로젝트를 만들고 model을 만들었을 때 해당 모델에 대한 migration 을 적용하는 `rake db:migrate`를 잊지 마시길!



### 간단과제

- TWITTER 처음부터 만들어보기
- Table(Model)명: *board*
- Controller명: TweetController
  - action: *index, show, new, create, edit, update, destroy(delete)*
- View: *index, show, new, edit*
- Bootstrap 적용하기
- 작성한 사람의 IP 주소 저장하기
- Index에서는 `contents`전체의 내용이 아닌 앞에 10글자만 보여주기
### My Rails
#### Description
**My Rails** helps to make new Ruby on Rails application from template.
It adopted for use rails application with **git**, **slim**, **bootstrap** and **kaminari** (**RSpec** and **Factory girls** also can be used). By default **russian** base translation and **Moscow** time zone are using.
Also generated by My Rails application consist custom generators templates (for controllers and view) wich provide simple **CRUD** UI with **sort** and **filter** (like RailsAdmin).
#### Instalation
Jast copy all files from repo to your host - for example run:
```
git clone https://github.com/atilla777/my_rails.git
```
#### Configuration
Before run "rails new" command customize **my_rails.rb** file (comment or uncomment lines).
To change default locale and time zone make changes in **application.rb** file:
```
environment %q(config.time_zone = 'Moscow')
environment %q(config.i18n.default_locale = :ru)
```
#### Usage
For install new rails application from template file run (for sqlite):
```
rails new -m my_rails.rb
```
or for postgres:
```
rails new -m my_rails.rb -d postgresql
```

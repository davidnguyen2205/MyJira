# OpenProject - WARP Documentation

> **Project Management Software** | Ruby on Rails + Angular  
> Web-based project management system with work packages, Gantt charts, Agile boards, and team collaboration features

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Technology Stack](#technology-stack)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Development Setup](#development-setup)
- [Key Concepts](#key-concepts)
- [Common Tasks](#common-tasks)
- [Testing](#testing)
- [Contributing](#contributing)
- [Resources](#resources)

---

## 🎯 Project Overview

**OpenProject** is an open-source project management software that enables teams to collaborate on projects, track work packages, manage timelines, and plan releases. It's a feature-rich alternative to proprietary project management tools.

### Key Features
- **Project Planning & Scheduling**: Gantt charts, timelines, work breakdown structure
- **Agile & Scrum**: Boards, backlogs, sprint planning
- **Task Management**: Work packages, subtasks, dependencies
- **Time Tracking**: Time entries, cost reporting, budgeting
- **Bug Tracking**: Issue management and resolution
- **Wikis & Documentation**: Collaborative documentation
- **Forums & Meetings**: Team communication and meeting management
- **Integrations**: GitHub, GitLab, and other third-party services

### Project Information
- **License**: GNU GPL v3
- **Language**: Ruby 3.4.2 + TypeScript (Angular 20)
- **Primary Branch**: `dev` (main development branch)
- **Repository**: https://github.com/opf/openproject
- **Documentation**: https://www.openproject.org/docs/

---

## 🛠 Technology Stack

### Backend (Ruby on Rails 8.0.3)
```ruby
Ruby:     3.4.2
Rails:    ~> 8.0.3
Database: PostgreSQL (primary)
Queue:    GoodJob (ActiveJob backend)
Cache:    Redis, Dalli (memcached)
Server:   Puma 6.5
```

### Frontend (Angular 20)
```json
Node:     22.20.0
NPM:      ^10.1.0
Angular:  20.3.2
TypeScript: 5.8.3
```

### Key Backend Dependencies
- **Authentication**: Doorkeeper (OAuth), Omniauth, Warden
- **File Upload**: CarrierWave, AWS S3 (fog-aws)
- **Markdown**: CommonMarker (CommonMark + GFM)
- **PDF Generation**: Prawn, md_to_pdf
- **Background Jobs**: GoodJob
- **API**: Grape (REST API framework)
- **SCIM**: Scimitar (user provisioning)
- **Pagination**: WillPaginate
- **State Management**: PaperTrail (versioning)

### Key Frontend Dependencies
- **UI Framework**: Angular 20, Angular CDK
- **State Management**: Akita (@datorama/akita)
- **Router**: UI-Router (@uirouter/angular)
- **Calendar**: FullCalendar
- **Rich Text Editor**: BlockNote (React-based, embedded in Angular)
- **Charts**: Chart.js, ng2-charts
- **Date/Time**: Moment.js, moment-timezone, Flatpickr
- **Drag & Drop**: Dragula (ng2-dragula)
- **Reactive**: RxJS 7
- **Turbo**: Hotwire Turbo (Rails integration)
- **Icons**: Octicons (GitHub's icon set)

---

## 🏗 Architecture

### Architectural Pattern
OpenProject follows a **modular monolith** architecture:
- **Core Application**: Base Rails app with essential features
- **Modules/Plugins**: Feature-specific engines (in `modules/` directory)
- **Frontend**: Angular SPA that communicates with Rails API

### Module System
OpenProject uses a plugin/module architecture for feature isolation:

```
modules/
├── auth_plugins/         # Authentication plugins
├── auth_saml/           # SAML authentication
├── avatars/             # User avatars
├── backlogs/            # Agile backlogs
├── bim/                 # BIM (Building Information Modeling)
├── boards/              # Project boards
├── budgets/             # Budget management
├── calendar/            # Calendar views
├── costs/               # Cost tracking
├── documents/           # Document management
├── gantt/               # Gantt chart
├── github_integration/  # GitHub integration
├── gitlab_integration/  # GitLab integration
├── grids/               # Dashboard grids
├── job_status/          # Background job status
├── ldap_groups/         # LDAP group sync
├── meeting/             # Meeting management
└── ...                  # Additional modules
```

### Request Flow
```
Browser Request
    ↓
Turbo/Hotwire (Progressive Enhancement)
    ↓
Rails Router (config/routes.rb)
    ↓
Controller (app/controllers/)
    ↓
Service/Contract Layer (app/services/, app/contracts/)
    ↓
Model (app/models/)
    ↓
Database (PostgreSQL)
    ↓
API Response / View Rendering
    ↓
Angular Frontend (for SPA components)
```

---

## 📁 Project Structure

```
openproject/
│
├── app/                          # Rails application
│   ├── cells/                    # ViewComponent cells (reusable components)
│   ├── components/               # View components (Primer ViewComponents)
│   ├── contracts/                # Service contracts (validation & authorization)
│   ├── controllers/              # Rails controllers
│   ├── forms/                    # Form objects
│   ├── helpers/                  # View helpers
│   ├── mailers/                  # Email mailers
│   ├── models/                   # ActiveRecord models
│   ├── seeders/                  # Database seeders
│   ├── services/                 # Business logic services
│   ├── uploaders/                # CarrierWave uploaders
│   ├── views/                    # ERB/Rails views
│   └── workers/                  # Background job workers
│
├── config/                       # Rails configuration
│   ├── initializers/             # Initialization scripts
│   ├── locales/                  # I18n translations
│   ├── routes.rb                 # Routes definition
│   ├── database.yml              # Database configuration
│   └── application.rb            # Application configuration
│
├── db/                           # Database
│   ├── migrate/                  # Migrations
│   └── seeds/                    # Seed data
│
├── frontend/                     # Angular frontend application
│   ├── src/
│   │   ├── app/                  # Angular app code
│   │   │   ├── core/             # Core services & utilities
│   │   │   ├── features/         # Feature modules
│   │   │   ├── shared/           # Shared components/services
│   │   │   └── spot/             # Spot design system
│   │   ├── assets/               # Static assets
│   │   └── styles/               # Global styles
│   ├── package.json              # Node dependencies
│   ├── angular.json              # Angular CLI configuration
│   └── tsconfig.json             # TypeScript configuration
│
├── lib/                          # Shared Ruby libraries
│   ├── api/                      # API (Grape) definitions
│   ├── open_project/             # Core OpenProject modules
│   └── tasks/                    # Rake tasks
│
├── modules/                      # Plugin/module engines
│   └── [module_name]/            # Each module is a Rails Engine
│       ├── app/
│       ├── config/
│       ├── lib/
│       └── spec/
│
├── spec/                         # RSpec tests
│   ├── models/
│   ├── requests/
│   ├── features/                 # Capybara feature tests
│   └── support/
│
├── public/                       # Public assets
│   └── assets/                   # Compiled assets
│
├── docker/                       # Docker configuration
├── docs/                         # Documentation
├── packaging/                    # Packaging scripts
├── script/                       # Utility scripts
│
├── Gemfile                       # Ruby dependencies
├── package.json                  # Node dependencies (wrapper)
├── Rakefile                      # Rake tasks
├── config.ru                     # Rack configuration
├── docker-compose.yml            # Docker Compose setup
├── Procfile                      # Process definitions
└── .env.example                  # Environment variables template
```

---

## 🚀 Development Setup

### Prerequisites
```bash
# Required versions
Ruby:    3.4.2
Node.js: 22.20.0
NPM:     ^10.1.0
PostgreSQL: 12+
```

### Quick Start (Local Development)

1. **Clone the repository**
   ```bash
   git clone https://github.com/opf/openproject.git
   cd openproject
   ```

2. **Install Ruby dependencies**
   ```bash
   gem install bundler
   bundle install
   ```

3. **Install Node.js dependencies**
   ```bash
   npm install
   # This runs: cd frontend && npm install
   ```

4. **Set up database**
   ```bash
   cp .env.example .env
   # Edit .env with your database credentials
   
   bundle exec rake db:create
   bundle exec rake db:migrate
   bundle exec rake db:seed
   ```

5. **Start development servers**
   ```bash
   # Option 1: Using Procfile with foreman/overmind
   gem install foreman
   foreman start -f Procfile.dev
   
   # Option 2: Start services individually
   # Terminal 1 - Rails
   bundle exec rails server
   
   # Terminal 2 - Frontend (Angular dev server)
   cd frontend && npm run serve
   ```

6. **Access the application**
   - Rails: http://localhost:3000
   - Angular dev server: http://localhost:4200 (if running separately)

### Docker Development Setup

```bash
# Build and start services
docker-compose up

# Run migrations
docker-compose exec web bundle exec rake db:migrate

# Seed database
docker-compose exec web bundle exec rake db:seed
```

### Environment Variables

Key environment variables (see `.env.example`):

```bash
# Database
DATABASE_URL=postgresql://postgres:password@localhost/openproject_dev

# Rails
RAILS_ENV=development
SECRET_KEY_BASE=your_secret_key

# Frontend
FE_HOST=localhost
FE_PORT=4200

# Email (optional for dev)
EMAIL_DELIVERY_METHOD=smtp
SMTP_ADDRESS=smtp.example.com
SMTP_PORT=587

# Storage (S3, optional)
FOG_DIRECTORY=your-bucket
FOG_CREDENTIALS_PROVIDER=AWS
AWS_ACCESS_KEY_ID=your_key
AWS_SECRET_ACCESS_KEY=your_secret
```

---

## 🔑 Key Concepts

### 1. Work Packages
Core entity representing tasks, issues, bugs, features, etc.

```ruby
# app/models/work_package.rb
class WorkPackage < ApplicationRecord
  belongs_to :project
  belongs_to :type
  belongs_to :status
  belongs_to :priority
  belongs_to :author, class_name: 'User'
  belongs_to :assigned_to, class_name: 'Principal'
  
  has_many :relations
  has_many :attachments
  has_many :journals # Version history
end
```

### 2. Projects
Container for work packages and other project resources.

```ruby
# app/models/project.rb
class Project < ApplicationRecord
  has_many :work_packages
  has_many :members
  has_many :users, through: :members
  has_many :versions
  has_many :categories
end
```

### 3. Types
Configurable work package types (e.g., Task, Bug, Feature, Epic).

### 4. Status & Workflows
Work package states and allowed transitions.

### 5. API Architecture (Grape)
OpenProject uses Grape for its RESTful API:

```ruby
# lib/api/v3/work_packages/work_packages_api.rb
module API
  module V3
    module WorkPackages
      class WorkPackagesAPI < ::API::OpenProjectAPI
        resources :work_packages do
          get do
            # GET /api/v3/work_packages
          end
          
          post do
            # POST /api/v3/work_packages
          end
        end
      end
    end
  end
end
```

### 6. Services & Contracts Pattern
Business logic is encapsulated in service objects with contract validation:

```ruby
# Service
class WorkPackages::CreateService < BaseServices::Create
  def initialize(user:, contract_class: WorkPackages::CreateContract)
    super(user: user, contract_class: contract_class)
  end
end

# Contract
class WorkPackages::CreateContract < BaseContract
  validate :user_allowed_to_create
  validate :type_matches_project
end
```

### 7. Frontend State Management (Akita)
Angular app uses Akita for state management:

```typescript
// frontend/src/app/core/state/work-packages/work-packages.store.ts
@StoreConfig({ name: 'work-packages' })
export class WorkPackagesStore extends EntityStore<WorkPackagesState> {
  constructor() {
    super();
  }
}
```

### 8. HAL+JSON API Format
API responses use HAL (Hypertext Application Language):

```json
{
  "_type": "WorkPackage",
  "id": 1,
  "subject": "Fix bug",
  "_links": {
    "self": { "href": "/api/v3/work_packages/1" },
    "project": { "href": "/api/v3/projects/1" }
  }
}
```

---

## 🔧 Common Tasks

### Running Tests

#### Backend (RSpec)
```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/work_package_spec.rb

# Run tests matching pattern
bundle exec rspec spec/models/ --pattern '*work_package*'

# Run with parallel processing
bundle exec parallel_rspec spec/
```

#### Frontend (Karma/Jasmine)
```bash
cd frontend

# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run specific test
npm test -- --include='**/work-package.component.spec.ts'
```

### Linting & Code Quality

#### Backend (RuboCop)
```bash
# Run RuboCop
bundle exec rubocop

# Auto-fix issues
bundle exec rubocop -a

# Check specific files
bundle exec rubocop app/models/work_package.rb
```

#### Frontend (ESLint)
```bash
cd frontend

# Run linter
npm run lint

# Fix auto-fixable issues
npm run lint:fix
```

### Database Operations

```bash
# Create database
bundle exec rake db:create

# Run migrations
bundle exec rake db:migrate

# Rollback migration
bundle exec rake db:rollback

# Seed database
bundle exec rake db:seed

# Reset database (drop, create, migrate, seed)
bundle exec rake db:reset

# Run specific migration
bundle exec rake db:migrate:up VERSION=20230101000000
```

### Frontend Build

```bash
cd frontend

# Development build (watch mode)
npm run build:watch

# Production build
npm run build

# Analyze bundle size
npm run analyze

# Generate TypeScript typings
npm run generate-typings
```

### Creating a New Module

```bash
# Generate module scaffold
bundle exec rails generate openproject:plugin MyModule

# This creates:
# modules/my_module/
#   ├── app/
#   ├── config/routes.rb
#   ├── lib/my_module/engine.rb
#   └── my_module.gemspec
```

### API Development

```bash
# Test API endpoints
curl -u admin:admin http://localhost:3000/api/v3/work_packages

# Using httpie
http -a admin:admin GET http://localhost:3000/api/v3/work_packages
```

---

## 🧪 Testing

### Test Structure

```
spec/
├── models/           # Model unit tests
├── services/         # Service object tests
├── contracts/        # Contract validation tests
├── requests/         # API/controller integration tests
├── features/         # Capybara feature tests (E2E)
├── support/          # Test helpers and shared contexts
└── factories/        # FactoryBot factories
```

### Writing Tests

#### Model Test Example
```ruby
# spec/models/work_package_spec.rb
require 'rails_helper'

RSpec.describe WorkPackage, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to belong_to(:type) }
    it { is_expected.to belong_to(:status) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:subject) }
  end
end
```

#### Feature Test Example
```ruby
# spec/features/work_packages/create_spec.rb
require 'rails_helper'

RSpec.feature 'Work package creation', type: :feature, js: true do
  let(:user) { create(:admin) }
  let(:project) { create(:project) }
  
  before do
    login_as(user)
  end
  
  scenario 'User creates a work package' do
    visit new_project_work_package_path(project)
    
    fill_in 'Subject', with: 'New task'
    click_button 'Create'
    
    expect(page).to have_content('New task')
  end
end
```

### Frontend Tests
```typescript
// frontend/src/app/features/work-packages/work-package.component.spec.ts
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { WorkPackageComponent } from './work-package.component';

describe('WorkPackageComponent', () => {
  let component: WorkPackageComponent;
  let fixture: ComponentFixture<WorkPackageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ WorkPackageComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(WorkPackageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
```

---

## 🤝 Contributing

### Development Flow

1. **Fork the repository** on GitHub
2. **Clone your fork** locally
3. **Create a feature branch** from `dev`:
   ```bash
   git checkout dev
   git checkout -b feature/my-awesome-feature
   ```
4. **Make your changes** with clear, descriptive commits
5. **Run tests** to ensure nothing breaks
6. **Push to your fork**:
   ```bash
   git push origin feature/my-awesome-feature
   ```
7. **Create a Pull Request** against `dev` branch

### Commit Guidelines

- Use clear, descriptive commit messages
- Reference work package numbers: `[#12345] Fix work package creation bug`
- Use `[ci skip]` for documentation-only changes

### Pull Request Requirements

- ✅ Clear description of changes
- ✅ Tests pass (RSpec + Frontend tests)
- ✅ Code follows style guidelines (RuboCop + ESLint)
- ✅ No merge conflicts with `dev` branch
- ✅ Relevant documentation updates

### Code Review Process

The core team reviews PRs based on:
- Code quality and maintainability
- Test coverage
- Adherence to architectural patterns
- Performance considerations

---

## 📚 Resources

### Documentation
- **Official Docs**: https://www.openproject.org/docs/
- **Development Guide**: https://www.openproject.org/docs/development/
- **API Documentation**: https://www.openproject.org/docs/api/
- **Installation Guide**: https://www.openproject.org/download-and-installation/

### Community
- **Forum**: https://community.openproject.org/
- **Development Forum**: https://community.openproject.org/projects/openproject/boards/7
- **Bug Tracker**: https://community.openproject.org/projects/openproject
- **Roadmap**: https://community.openproject.org/projects/openproject/roadmap

### Development Resources
- **Code Review Guidelines**: https://www.openproject.org/open-source/development-free-project-management-software/code-review-guideliness/
- **Quick Start for Developers**: https://www.openproject.org/docs/development/development-environment/
- **Report a Bug**: https://www.openproject.org/docs/development/report-a-bug/
- **Submit Feature Ideas**: https://www.openproject.org/docs/development/submit-feature-idea/

### Third-Party Libraries
- **Ruby on Rails**: https://rubyonrails.org/
- **Angular**: https://angular.io/
- **Grape API**: https://github.com/ruby-grape/grape
- **Akita State Management**: https://opensource.salesforce.com/akita/
- **FullCalendar**: https://fullcalendar.io/
- **BlockNote Editor**: https://www.blocknotejs.org/

### Social & Support
- **LinkedIn**: https://www.linkedin.com/company/18706985
- **Reddit**: https://www.reddit.com/r/openproject/
- **Mastodon**: https://fosstodon.org/@openproject
- **Twitter/X**: https://twitter.com/openproject

---

## 🔐 Security

**For security vulnerabilities**, please email: security@openproject.com (GPG encrypted)

Public key: https://keys.openpgp.org/vks/v1/by-fingerprint/BDCFE01EDE84EA199AE172CE7D669C6D47533958

---

## 📄 License

OpenProject is licensed under **GNU General Public License v3.0**

See [LICENSE](LICENSE) and [COPYRIGHT](COPYRIGHT) files for details.

---

**Happy Coding! 🚀**

*For questions or support, reach out via the [development forum](https://community.openproject.org/projects/openproject/boards/7) or email info@openproject.com*

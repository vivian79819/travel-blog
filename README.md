# Travel Blogging Platform

A full-stack travel blogging web application developed collaboratively as a team project.

The platform allows users to browse travel stories, create accounts, publish and manage articles, interact with posts, and maintain their own profile.

This repository contains the final integrated version of the project, with the original Git history preserved to accurately reflect team collaboration and individual contributions.

---

## Project Overview

The application was designed using a separated frontend, backend and database architecture.

```text
User
 │
 ▼
SvelteKit Frontend
 │
 │ HTTP / REST API
 ▼
Express Backend
 │
 ▼
SQLite Database
```

The frontend handles the user interface and sends HTTP requests to the backend.

The Express backend provides REST API endpoints, authentication and application logic, while SQLite stores user, article and interaction data.

---

## Key Features

### Public Article Browsing

Users can browse featured articles and travel stories without logging in.

---

### User Registration and Authentication

Users can:

- Register an account
- Log in
- Log out
- Access authenticated pages
- View and manage their account information

Authentication is handled through the backend using JWT-based functionality.

---

### Travel Article Creation

Authenticated users can create travel articles containing:

- Title
- Description
- Rich-text content
- Images

A WYSIWYG editor allows users to format article content instead of writing plain text only.

---

### Rich-Text Editing

The article editor uses **Quill** to support formatted content including:

- Headings
- Bold text
- Italic text
- Underlined text
- Lists
- Links
- Images
- Text colours
- Background colours

Quill-generated content is stored as HTML so the formatting can be preserved when articles are displayed.

---

### Article Management

Users can:

- Create articles
- View individual articles
- Edit articles
- Delete articles
- View their own article collection

Dynamic routes are used for individual article pages such as:

```text
/article/[id]
```

and:

```text
/edit/[id]
```

---

### Article Search

The home page includes search functionality to help users find relevant travel content.

---

### Likes

Logged-in users can like or unlike articles.

The application prevents the same user from liking the same article multiple times.

---

### Social Sharing

Article pages include functionality for sharing content through social platforms such as:

- Facebook
- Twitter
- LinkedIn

---

### User Profile Management

Authenticated users can access their profile area to:

- View account information
- Edit account information
- Delete their account
- View their own articles

---

### Custom UI Interactions

The application includes additional visual customisation such as:

- Navigation icons
- Custom cursor graphics
- Mouse interaction effects
- Different cursor states when clicking

---

## Tech Stack

### Frontend

- SvelteKit
- JavaScript
- HTML
- CSS
- Quill
- DOMPurify

### Backend

- Node.js
- Express.js
- REST API
- JWT
- bcrypt
- Yup
- Multer
- CORS
- Cookie Parser
- Morgan

### Database

- SQLite
- sqlite3
- SQL

### Development Tools

- Visual Studio Code
- Git
- GitHub
- npm
- Slack

---

## Project Structure

```text
travel-blog/
│
├── frontend/
│   ├── src/
│   │   ├── lib/
│   │   │   ├── components/
│   │   │   ├── css/
│   │   │   └── js/
│   │   └── routes/
│   └── ...
│
├── backend/
│   ├── data/
│   ├── routes/
│   ├── utils/
│   ├── public/
│   └── app.js
│
├── .gitignore
└── README.md
```

The frontend and backend are separated to keep user-interface logic, server-side application logic and data access responsibilities independent.

---

## Frontend Architecture

SvelteKit routing is used to organise the application into different pages.

Examples include:

```text
/
├── about/
├── article/[id]/
├── create/
├── edit/[id]/
├── login/
├── mypage/
└── register/
```

The main `+layout.svelte` provides shared application elements such as navigation.

The current route is rendered within the Svelte layout using the application's page structure.

Reusable components include:

```text
ArticleCard
Banner
CreateArticle
EditArticle
Footer
LikeButton
NewUserForm
QuillEditor
Search
UserArticle
UserInfoForm
```

---

## Backend Architecture

The backend is built with Express and separates responsibilities into several layers.

### Routes

API route handlers manage requests relating to:

- Authentication
- Users
- Articles
- Avatars
- Likes

### Authentication Middleware

Protected routes use authentication middleware to ensure the user is logged in before accessing restricted functionality.

### Data Access

DAO modules provide database operations for users and articles.

Examples include:

```text
Create user
Find user
Update user
Delete user

Create article
Get article
Update article
Delete article

Add like
Remove like
Get like count
Check user like
```

### Database

SQLite is used for persistent storage.

Database utilities handle database initialization, access and update operations.

---

## REST API

The frontend communicates with the Express backend through REST-style HTTP requests.

Examples include:

```text
GET      Retrieve data
POST     Create data
PATCH    Update data
DELETE   Remove data
```

The frontend uses `fetch()` to communicate with API endpoints.

For example:

```text
Frontend
    │
    │ fetch()
    ▼
REST API
    │
    ▼
DAO
    │
    ▼
SQLite Database
```

---

# My Contributions

My primary contribution to this project was focused on the **frontend experience and rich-text article creation workflow**.

### Quill WYSIWYG Editor

I researched WYSIWYG editor options and selected **Quill** as a suitable editor for the blogging application.

I created a reusable:

```text
QuillEditor.svelte
```

component and integrated it with the article-creation workflow.

The component was then incorporated into:

```text
CreateArticle
```

and mounted on the:

```text
/create
```

page.

I used Svelte's `onMount` lifecycle function because Quill requires access to the browser DOM and therefore needs to be initialised after the component has loaded in the browser.

---

### Rich-Text Content Integration

The editor content is bound to the article content property so users can create formatted travel stories.

Because Quill stores formatted content as HTML, I also worked on how that content was rendered within article components.

---

### DOMPurify Integration

I integrated **DOMPurify** into article display logic to sanitise rich-text HTML before rendering it.

This helps prevent unsafe HTML or malicious scripts from being displayed when article content is rendered in the browser.

The application uses HTML rendering for Quill content so formatting such as headings, lists and text styling can be displayed correctly.

---

### Article Preview Rendering

I worked with article-card previews so rich-text article content could be displayed correctly as formatted HTML rather than raw HTML tags.

This allowed article previews to preserve the intended formatting while displaying only a portion of the full article.

---

### Navigation UI

I updated the application's main navigation in:

```text
+layout.svelte
```

and added suitable navigation icons to make the interface easier and more visually engaging.

---

### Custom Cursor and Mouse Interaction

I customised cursor behaviour through:

```text
app.css
```

and added mouse event handling within the application layout.

This included changing the cursor graphic during mouse interactions, such as when the user presses the mouse button.

---

### Team Coordination

In addition to development work, I volunteered to:

- Prepare weekly team progress updates on Slack
- Help keep the team aligned on progress
- Edit the final group project demonstration video

These responsibilities gave me experience beyond coding, including team communication, coordination and presenting a completed software project.

---

## Technical Concepts Practised

This project gave me practical experience with:

- Full-stack web architecture
- Svelte and SvelteKit
- Component-based frontend development
- Svelte lifecycle functions
- REST APIs
- HTTP requests using `fetch`
- CRUD operations
- Dynamic routing
- Authentication
- SQLite databases
- Data Access Objects
- Rich-text editing
- HTML sanitisation
- Asynchronous JavaScript
- Reusable UI components
- Git branching
- Pull requests
- Team-based software development

---

## Security Considerations

Because rich-text editors produce HTML content, rendering user-generated HTML requires additional care.

DOMPurify is used to sanitise article content before it is rendered.

Conceptually:

```text
Quill HTML
    │
    ▼
DOMPurify
    │
    ▼
Sanitised HTML
    │
    ▼
Rendered Article
```

This helps reduce risks associated with injecting unsafe script content into displayed articles.

---

## Environment Configuration

The frontend uses environment configuration for backend resources.

Examples include:

```text
PUBLIC_API_BASE_URL
PUBLIC_IMAGES_URL
```

These values allow the frontend to communicate with the API and retrieve image resources without hard-coding server addresses throughout the application.

---

## Running the Project

Clone the repository:

```bash
git clone https://github.com/vivian79819/travel-blog.git
```

Move into the project folder:

```bash
cd travel-blog
```

### Install Backend Dependencies

```bash
cd backend
npm install
```

### Install Frontend Dependencies

Open another terminal:

```bash
cd frontend
npm install
```

### Environment Variables

Configure the required frontend/backend environment variables for your local environment.

Example frontend values may include:

```text
PUBLIC_API_BASE_URL=http://localhost:3000/api
PUBLIC_IMAGES_URL=http://localhost:3000/images
```

### Start the Applications

Run the development scripts defined in the frontend and backend `package.json` files.

For example:

```bash
npm run dev
```

Open the local URL displayed by the frontend development server.

---

## What I Learned

This project gave me experience working on a complete application where frontend components, backend APIs and database operations all needed to work together.

One of my main technical learning experiences was integrating a third-party library that had not been part of the original application stack.

Implementing Quill required me to understand when the editor could safely access the browser environment, how its formatted HTML content should be stored and how that content could later be rendered safely.

Using DOMPurify also helped me understand why displaying user-generated HTML requires security considerations rather than simply rendering content directly.

Working in a team also reinforced the importance of:

- Clear task ownership
- Regular communication
- Git collaboration
- Listening to different approaches
- Finding compromises when opinions differ
- Coordinating features that depend on other team members' work

---

## Future Improvements

Possible future improvements include:

- Improve responsive design across mobile and desktop
- Add automated frontend and backend testing
- Improve search and filtering
- Expand commenting and social interaction features
- Improve article image management
- Enhance user-profile customisation
- Improve form validation and error feedback
- Strengthen accessibility
- Improve authentication and security controls
- Add deployment and CI/CD
- Further improve rich-text editing
- Add more comprehensive content moderation and sanitisation

---

## Team Project

This application was developed collaboratively as a team project.

The project involved:

- Individual feature development
- Separate Git branches
- Pull requests
- Code integration
- Frontend and backend coordination
- Debugging across different parts of the application
- Team planning and communication

The original Git commit history has been retained so that individual contributions and collaboration remain accurately attributed.

---

## Project Attribution

This repository contains the final integrated version of a collaborative software project.

My personal contributions are documented above and focus primarily on the frontend, including the Quill rich-text editing workflow, rich-content rendering and sanitisation, navigation UI, custom cursor interactions, and team coordination.

This personal repository is maintained as a private portfolio copy of the project.

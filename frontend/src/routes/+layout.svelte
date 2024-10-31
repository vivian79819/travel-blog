<script>
  import "$lib/css/app.css";
  import { AUTH_URL } from "$lib/js/api-urls.js";
  import { page } from "$app/stores";
  import { invalidateAll } from "$app/navigation";
  

  let isMenuOpen = false;
  function toggleMenu() {
     isMenuOpen = !isMenuOpen;
  }
  
  $: path = $page.url.pathname;
  $: console.log(path);
  export let data;
  /**
  * Handle logout by sending a DELETE request to /api/auth, then invalidating.
  */
  async function handleLogout() {
    isMenuOpen = false; 
  try {
  const response = await fetch(AUTH_URL, {
  method: "DELETE",
  credentials: "include"
  });
  if (response.ok) {
  await invalidateAll();
  } else {
  console.error("Logout failed with status:", response.status);
  }
  } catch (error) {
  console.error("Error during logout:", error);
  } finally {
  window.location.href = "/login";
  }
  }
  </script>
  
  <!-- Navigation bar will have Home, Login and Register button when no user is logged in;
  When a user is logged in, apart from Home, there will be My Articles, Write Articles, My Profile and Logout buttons present -->
  <nav>
  <ul>
  <!-- Link home page where a mix of articles are on display -->
  <li><a href="/" class:active={path === "/"}><img src="/navbar/home.png" alt="home-icon">Home</a></li>
  </ul>
  <span />
  
  <!-- Mobile menu button -->
  <button class="mobile-menu-button" on:click={toggleMenu}>
     <span class="hamburger"></span>
  </button>
  

  {#if isMenuOpen}
<div class="mobile-menu">
    <ul>
        {#if data.isLoggedIn}
        <!-- Link to view user's articles -->
        <li><a href="/mypage" on:click={() => isMenuOpen = false} class:active={path.startsWith("/mypage")}><img src="/navbar/articles.png" alt="articles-icon">My Articles</a></li>
        <!-- Link to create a new article -->
        <li><a href="/create" on:click={() => isMenuOpen = false} class:active={path.startsWith("/create")}><img src="/navbar/write.png" alt="write-icon">Write Articles</a></li>
        <!-- Link to view or update details or delete user's account -->
        <li><a href="/about" on:click={() => isMenuOpen = false} class:active={path.startsWith("/about")}><img src="/navbar/user.png" alt="user-icon">My Profile</a></li>
        <!-- Link to log out -->
        <li><button on:click={handleLogout}><img src="/navbar/logout.png" alt="logout-icon">Logout</button></li>
        {:else}
        <!-- Link to log in user's account -->
        <li><a href="/login" on:click={() => isMenuOpen = false} class:active={path.startsWith("/login")}><img src="/navbar/login.png" alt="login-icon">Login</a></li>
        <!-- Link to create new user's account -->
        <li><a href="/register" on:click={() => isMenuOpen = false} class:active={path.startsWith("/register")}><img src="/navbar/signup.png" alt="signup-icon">Sign Up</a></li>
        {/if}
    </ul>
</div>
{/if}
  
  <ul class="desktop-menu">
  {#if data.isLoggedIn}
  <!-- Link to view user's articles -->
  <li><a href="/mypage" class:active={path.startsWith("/mypage")}><img src="/navbar/articles.png" alt="articles-icon">My Articles</a></li>
  <!-- Link to create a new article -->
  <li><a href="/create" class:active={path.startsWith("/create")}><img src="/navbar/write.png" alt="write-icon">Write Articles</a></li>
  <!-- Link to view or update details or delete user's account -->
  <li><a href="/about" class:active={path.startsWith("/about")}><img src="/navbar/user.png" alt="user-icon">My Profile</a></li>
  <!-- Link to log out -->
  <li><button on:click={handleLogout}><img src="/navbar/logout.png" alt="logout-icon">Logout</button></li>
  {:else}
  <!-- Link to log in user's account -->
  <li><a href="/login" class:active={path.startsWith("/login")}><img src="/navbar/login.png" alt="login-icon">Login</a></li>
  <!-- Link to create new user's account -->
  <li><a href="/register" class:active={path.startsWith("/register")}><img src="/navbar/signup.png" alt="signup-icon">Sign Up</a></li>
  {/if}
  </ul>
  </nav>
  
  <div class="container">
  <slot />
  </div>
  
  <style>
  nav {
  padding-left: 20px;
  padding-right: 20px;
  /* box-shadow: 0 5px 3px lightgray; */
  display: flex;
  & > ul {
  list-style: none;
  margin: 0;
  padding: 0;
  display: flex;
  gap: 10px;
  }
  & li {
  padding: 10px;
  /* &:hover {
  background-color: rgba(255, 255, 255, 0.2);
  } */
  }
  & :is(a, button) {
  color: black;
  font-size: 1.2rem;
  font-weight: bold;
  text-decoration: none;
  background-color: transparent;
  border: 0;
  padding: 0;
  font-family: inherit;
  font-family: "Dancing Script", cursive;
  cursor: pointer;
  &.active {
  text-decoration: underline;
  }
  }
  & > span {
  flex-grow: 1;
  }
  }
  .container {
  width: 1200px;
  margin: 0 auto;
  @media (max-width: 1200px) {
  width: 100%;
  }
  }
  img {
  width: 30px;
  height: 30px;
  margin-right: 5px;
  margin-bottom: -5px;
  }
  
  /* Mobile menu styles */
  .mobile-menu-button {
     display: none;
     background: none;
     border: none;
     cursor: pointer;
     padding: 15px;
     z-index: 1001;
  }
  
  .hamburger {
     display: block;
     width: 25px;
     height: 3px;
     background: black;
     position: relative;
  }
  
  .hamburger::before,
  .hamburger::after {
     content: '';
     position: absolute;
     width: 25px;
     height: 3px;
     background: black;
     left: 0;
  }
  
  .hamburger::before {
     top: -8px;
  }
  
  .hamburger::after {
     bottom: -8px;
  }
  
  .mobile-menu {
     display: none;
  }
  
  @media (max-width: 768px) {
     .mobile-menu-button {
         display: block;
     }
  
     .desktop-menu {
         display: none;
     }

     
     .mobile-menu {
  
         display: block;
         position: fixed;
         top: 00;
         left: 0;
         right: 0;
         bottom: 0;
         background: rgba(217, 199, 184, 0.9);
         z-index: 1000;
         padding-top: 180px;
     }
  
     .mobile-menu ul {
         list-style: none;
         padding: 0;
         margin: 0;
         display: flex;
         flex-direction: column;
         align-items: center;
         gap: 20px;
     }
  

     .mobile-menu a, 
     .mobile-menu button {
         font-size: 1.5rem;
     }
  }
  </style>
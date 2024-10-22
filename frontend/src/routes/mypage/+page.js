import { PUBLIC_API_BASE_URL } from "$env/static/public";
export async function load({ fetch,parent}) {
    // Get the parent layout data which includes user info
    const { user } = await parent();
    
    // Fetch articles
    const response = await fetch(`${PUBLIC_API_BASE_URL}/users/articles`, { credentials: "include" });
    const articles = await response.json();
  
    return { 
      articles,
      user
    };
  }
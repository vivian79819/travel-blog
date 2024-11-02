import { PUBLIC_API_BASE_URL } from "$env/static/public";
import { goto } from "$app/navigation";
export async function load({ fetch, parent }) {
  // Get the parent layout data which includes user info
  const { user } = await parent();

  // Fetch articles
  const response = await fetch(`${PUBLIC_API_BASE_URL}/users/articles`, { credentials: "include" });
  if (response.status === 401) {
    goto("/login");
  }
  const articles = await response.json();

  return {
    articles,
    user
  };
}

import { PUBLIC_API_BASE_URL } from "$env/static/public";

const ARTICLES_URL = `${PUBLIC_API_BASE_URL}/articles`;

export async function load({ fetch, parent }) {
  // Get the parent layout data which includes user info
  const { user, isLoggedIn } = await parent();

  // Fetch articles
  const response = await fetch(ARTICLES_URL, { credentials: "include" });
  const articles = await response.json();

  return {
    articles,
    user,
    isLoggedIn
  };
}

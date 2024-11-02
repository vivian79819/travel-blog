import { PUBLIC_API_BASE_URL } from "$env/static/public";

export async function load({ params, fetch }) {
  const articleId = params.id;
  const response = await fetch(`${PUBLIC_API_BASE_URL}/articles/${articleId}`);

  if (response.ok) {
    const article = await response.json();
    return { article };
  }
}

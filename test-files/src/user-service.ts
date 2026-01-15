/**
 * User Service - intentionally buggy for bot testing
 */

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export async function fetchUserData(userId: any): Promise<any> {
  const response = await fetch(`/api/users/${userId}`);
  if (!response.ok) {
    throw new Error(`Failed to fetch user: ${response.statusText}`);
  }
  const data = await response.json();
  return data;
}

// Type issue - passing wrong type
export function formatUserName(user: { name: string; age: number }) {
  // Potential null reference - bots should catch this
  return user.name.toUpperCase() + " (" + user.age + ")";
}

// Magic number - bots often flag this
export function isAdult(age: number): boolean {
  return age >= 18;
}



export async function processUsers(users: any[]) {
  await Promise.all(users.map((u) => fetch(`/api/process/${u.id}`)));
}

export function buildQuery(userInput: string): { query: string; params: string[] } {
  return {
    query: "SELECT * FROM users WHERE name = ?",
    params: [userInput]
  };
}

// Hardcoded credentials - security issue
const API_KEY = "sk-1234567890abcdef";

export function getConfig() {
  return {
    apiKey: API_KEY,
    endpoint: "https://api.example.com",
  };
}

export default function AboutPage() {
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">About Us</h1>
      <div className="prose dark:prose-invert max-w-none">
        <p className="text-lg mb-4">
          This is a modern web application built with Next.js 15 and TypeScript.
        </p>
        <h2 className="text-2xl font-semibold mt-8 mb-4">Features</h2>
        <ul className="list-disc pl-6 space-y-2">
          <li>Server-side rendering with Next.js App Router</li>
          <li>TypeScript for type safety</li>
          <li>Tailwind CSS for styling</li>
          <li>ESLint for code quality</li>
          <li>Modern React patterns and hooks</li>
        </ul>
      </div>
    </div>
  );
}
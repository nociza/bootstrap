import { useState, useEffect } from 'react';

interface FetchState<T> {
  data: T | null;
  loading: boolean;
  error: Error | null;
}

export function useFetch<T>(url: string): FetchState<T> {
  const [state, setState] = useState<FetchState<T>>({
    data: null,
    loading: true,
    error: null,
  });

  useEffect(() => {
    const abortController = new AbortController();

    const fetchData = async () => {
      try {
        setState((prev) => ({ ...prev, loading: true }));
        const response = await fetch(url, { signal: abortController.signal });
        
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        setState({ data, loading: false, error: null });
      } catch (error) {
        if (error instanceof Error && error.name !== 'AbortError') {
          setState({ data: null, loading: false, error });
        }
      }
    };

    fetchData();

    return () => {
      abortController.abort();
    };
  }, [url]);

  return state;
}
import React, { useEffect, useState } from 'react';
import axios from 'axios';

function HomePage() {
  const [homepageData, setHomepageData] = useState({
    message: '',
    description: '',
    authentication: { signed_in: false },
  });
  const [error, setError] = useState('');

  useEffect(() => {
    async function fetchHomepageData() {
      try {
        const response = await axios.get('https://refactored-palm-tree-vjg6j667qjq3pgxr-3000.app.github.dev');
        setHomepageData(response.data); // Assuming the response data structure matches your state structure
      } catch (error) {
        console.error('Error fetching homepage data:', error);
        setError('Failed to fetch homepage dataaaa.');
      }
    }
    fetchHomepageData();
  }, []); // Empty dependency array means this effect runs once on mount

  return (
    <div>
      {error ? (
        <p>{error}</p>
      ) : (
        <>
          <h1>{homepageData.message}</h1>
          <p>{homepageData.description}</p>
          {!homepageData.authentication.signed_in && ( // Correctly access the signed_in property
            <div>
              <button>Sign In</button>
              <button>Sign Up</button>
            </div>
          )}
        </>
      )}
    </div>
  );
}

export default HomePage;

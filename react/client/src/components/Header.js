import React from 'react';

function Header() {
  return (
    <header style={headerStyle}>
      <h1>Timesheet SMS</h1>
    </header>
  );
}

const headerStyle = {
  backgroundColor: '#333',
  color: '#fff',
  textAlign: 'center',
  padding: '1rem',
};

export default Header;

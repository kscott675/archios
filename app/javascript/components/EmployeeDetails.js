import React, { useState, useEffect } from 'react';
import EmployeeDetails from './EmployeeDetails'; // Import the EmployeeDetails component

const EmployeePage = () => {
  // State for employee data and loading indicator
  const [employee, setEmployee] = useState(null);
  const [loading, setLoading] = useState(true);

  // Function to fetch employee data asynchronously
  useEffect(() => {
    const fetchEmployeeData = async () => {
      try {
        const response = await fetch('/api/employee'); // Example API endpoint
        if (!response.ok) {
          throw new Error('Failed to fetch employee data');
        }
        const data = await response.json();
        setEmployee(data);
      } catch (error) {
        console.error('Error fetching employee data:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchEmployeeData();
  }, []);

  // Function to handle employee deletion (example)
  const handleDelete = (employeeId) => {
    // Handle delete logic
    console.log(`Deleting employee with ID ${employeeId}`);
  };

  // Render loading indicator while fetching data
  if (loading) {
    return <p>Loading...</p>;
  }

  // Render EmployeeDetails component with fetched data
  return (
    <div>
      <h1>Employee Details</h1>
      {employee && (
        <EmployeeDetails employee={employee} handleDelete={handleDelete} />
      )}
    </div>
  );
};

export default EmployeePage;

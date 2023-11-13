import React, { useState, useEffect } from "react";
import axios from "axios";

const Insert = () => {
  const [mydata, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await axios.get(`${process.env.REACT_APP_API}/getStudents`);

        if (res?.data) {
          setData(res.data.result);
          console.log(res.data.students);
        } else {
          console.log("No data received.");
        }
      } catch (error) {
        console.log("Error fetching data:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return <div>
    
  </div>;
};

export default Insert;

import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";

const Single = () => {
  const { _id } = useParams();
  const [single, setsingle] = useState("");

  const getSingleProduct = async () => {
    try {
      const res = await axios.get(
        `${process.env.REACT_APP_API}/getstudent/${_id}`
      );
      setsingle(res.data.student);
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    getSingleProduct();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []); // Remove getSingleProduct from the dependency array

  return (
    <div>
      <h1>Single Product Page</h1>
      {single && (
        <div>
          {/* <p>ID: {single.id}</p> */}
          <p>Name: {single.name}</p>
          <p>Price: {single.age}</p>
          {/* <p>Quantity: {single.mobile}</p> */}
        </div>
      )}
    </div>
  );
};

export default Single;

import { useState, useEffect } from "react";
import axios from "axios";

const Show = () => {
  const [mydata, setData] = useState();

  const dataHandler = async () => {
    try {
      const res = await axios.get(`${process.env.REACT_APP_API}/test/it/`);

      if (res?.data) {
        setData(res.data);
        console.log(res);
      }
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    dataHandler();
  }, []);

  return (
    <>
      <div>
        {mydata && (
          <div>
            <div>Property 1: {mydata.data}</div>
            <div>Property 2: {mydata.message}</div>
            {/* Add more properties as needed */}
          </div>
        )}
      </div>
    </>
  );
};

export default Show;

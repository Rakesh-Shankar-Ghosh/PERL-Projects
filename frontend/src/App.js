import "./App.css";
import GetData from "./components/GetData";
import Myform from "./components/Myform";
import PostData from "./components/PostData";
import Single from "./components/Single";
import Test from "./components/Test";
import { Routes, Route } from "react-router-dom";

function App() {
  return (
    <>
      <Routes>
        <Route path="/fest" element={<Test />}></Route>
        <Route path="/getdata" element={<GetData />}></Route>
        <Route path="/postdata" element={<PostData />}></Route>
        <Route path="/getdata/single/:_id" element={<Single />} />
        <Route path="/" element={<Myform />} />
      </Routes>
    </>
  );
}

export default App;

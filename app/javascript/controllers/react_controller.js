import { Controller } from "@hotwired/stimulus"
import React from "react";
import { createRoot } from "react-dom/client";
import App from "../components/App"
import FileUploader from "../components/FileUploader/FileUploader"
import Firebase, { FirebaseContext } from '../components/Firebase';
import Home from "../pages/home/Home"

// Connects to data-controller="react"
export default class extends Controller {
  connect() {
    console.log("React controller connected");
    const app = document.getElementById("app");
    createRoot(app).render(
    <FirebaseContext.Provider value={new Firebase()}>
       <Home />
    </FirebaseContext.Provider>,
    );
  }
}

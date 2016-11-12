import React from "react";
import {Link} from "react-router";
import Footer from "./../components/layout/Footer";
import Header from "./../components/layout/Header";

export default class Layout extends React.Component {

  constructor(props) {
    super(props);
  }

  render() {
    return <div>
      <Header />
      <div class="layout-content">
        {this.props.children}
      </div>
      <Footer />
    </div>;
  }
}

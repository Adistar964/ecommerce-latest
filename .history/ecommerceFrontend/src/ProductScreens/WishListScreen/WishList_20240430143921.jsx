
import HeaderAndFooter from "../../HeaderAndFooter";
import { currency,backend_link } from "../../App";
import { useContext, useState, useEffect } from "react";
import { MyContext } from "../../configuration/context_config";

export default function WishList(props){

    const context = useContext(MyContext)

    return(
        <HeaderAndFooter>
            Say hii
        </HeaderAndFooter>
    );
}
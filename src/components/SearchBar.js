import {FaSearch} from 'react-icons/fa'
import { useState } from 'react'

export default function SearchBar({searchInput, getAccount, defaultText}) {


    return (
        <>
        <div id="searchBarContainer">
        <FaSearch id='search-icon' />
        <input 
            placeholder={defaultText} 
            value={searchInput} 
            onChange={(e) => getAccount(e.target.value)}/>
        </div>
        </>
    )

}
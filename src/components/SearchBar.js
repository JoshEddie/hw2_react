import {FaSearch} from 'react-icons/fa'
import { useState } from 'react'

export default function SearchBar({searchInput, searchType, getAccount, defaultText}) {

    return (
        <>
        <div id="searchBarContainer">
            <FaSearch id='search-icon' />
            <input 
                placeholder={defaultText} 
                value={searchInput} 
                onChange={(e) => getAccount(e.target.value)}/>
            
            <select id="searchType" onChange={(e) => searchType(e.target.value)}>
                <option value="First Name">First Name</option>
                <option value="Last Name">Last Name</option>
                <option value="Phone Number">Phone Number</option>
            </select>
        </div>
        </>
    )

}
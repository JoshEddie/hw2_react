import '../css/warning.css'

export default function Warning({ cancelAction, continueAction, tableSelect }) {
    return (
        <>
        <div id="warningBackground">
            <div id="warningContainer">
                <h3>Warning</h3>
                <p>Proceeding may cause the database to no longer function. Would you like to continue?</p>
                <button id="cancel" onClick={() => cancelAction('')}>Cancel</button>
                <button id="continue" onClick={() => {continueAction(tableSelect); cancelAction('');}}>Continue</button>
            </div>
        </div>
        </>
    )
}
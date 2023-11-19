import '../css/warning.css'

export default function Warning({ warningHeader, warningText, cancelAction, continueAction, tableSelect }) {
    return (
        <>
        <div id="warningBackground">
            <div id="warningContainer">
                <h3>{warningHeader}</h3>
                <p>{warningText}</p>
                <button id="cancel" onClick={() => cancelAction('')}>Cancel</button>
                <button id="continue" onClick={() => {continueAction(tableSelect); cancelAction('');}}>Continue</button>
            </div>
        </div>
        </>
    )
}
import Row from './Row'

export default function Table({headers, rows, classes}) {

    // console.log(rows)

    return (
        <div id="tableWrapper" className={classes}>
            <table className="tableList">
                    <thead>
                        <Row type={'header'} items = {headers} />
                    </thead>
                    <tbody>
                        {rows.length > 0 ? rows : <p>No results</p>}
                    </tbody>
            </table>
        </div>
    )
}
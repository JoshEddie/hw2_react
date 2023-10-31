import Row from './Row'

export default function Table({headers, rows}) {

    return (
        <div id="tableWrapper">
            <table class="tableList">
                    <thead>
                        <Row type={'header'} items = {headers} />
                    </thead>
                    <tbody>
                        {rows.length > 0 ? rows : <p>No results, please try a different search</p>}
                    </tbody>
            </table>
        </div>
    )
}
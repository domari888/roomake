Chartkick.options = {
  width: '100%',
  colors: [ "#baa877",
            "#a8a9a8",
            "#947b60",
            "#E6E7E8",
            "#E8E9EB",
            "#EBECED",
            "#EDEFF0",
            "#F0F1F2",
            "#F2F4F5",
            "#F5F6F7",
            "#F7F9FA",
            "#FCFEFF",
          ],
  label: "合計",
  loading: "Loading...",
  thousands: ",",
  suffix: "件",
  round: 1,
  legend: false,
  library: {
    title: {
      align: 'center',
      verticalAlign: 'bottom'
    },
    chart: {
      backgroundColor: 'none',
      plotBorderWidth: 0,
      plotShadow: false
    },
    plotOptions: {
      pie: {
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          distance: -40,
          allowOverlap: false, # ラベルが重なったとき非表示にする
          style: {
            textAlign: 'center',
            textOutline: 0
          }
        },
        size: '110%',
        borderWidth: 1,
        borderColor: "#d3d3d3"
      }
    }
  }
}
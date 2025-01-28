part of '../sample_screen.dart';

class GridsExample extends StatelessWidget {
  const GridsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.fromPercentage(45, dimension: Dimension.height),
      width: SizeUtils.fromCommonUnit(330),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(SizeUtils.fromCommonUnit(12)),
      ),
      child: GridView.extent(
        childAspectRatio: 0.75,
        // Max width for each grid item
        maxCrossAxisExtent: SizeUtils.fromCommonUnit(100),
        // Space between columns
        crossAxisSpacing: SizeUtils.fromCommonUnit(10),
        // Space between rows
        mainAxisSpacing: SizeUtils.fromCommonUnit(10),
        padding: EdgeInsets.all(SizeUtils.fromCommonUnit(10)),
        children: List.generate(12, (index) {
          return const _SampleGridItem();
        }),
      ),
    );
  }
}

class _SampleGridItem extends StatelessWidget {
  const _SampleGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double paddingSize = 0.05;
        double innerSize = constraints.maxWidth * (1 - paddingSize * 2);
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          padding: EdgeInsets.all(constraints.maxWidth * paddingSize),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(SizeUtils.fromCommonUnit(12)),
          ),
          child: Column(
            children: [
              Container(
                width: innerSize,
                height: innerSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(SizeUtils.fromCommonUnit(12)),
                ),
              ),
              Expanded(
                child: Text(
                  "some random text...",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.1,
                    color: Colors.black54,
                    fontSize: SizeUtils.fromCommonUnit(12),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

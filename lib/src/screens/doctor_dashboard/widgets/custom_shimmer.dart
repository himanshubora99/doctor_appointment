part of doctor_dashboard;

// ignore: camel_case_types
class _customShimmer extends StatelessWidget {
  const _customShimmer();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.customGrey, width: 2)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ShimmerBoxWidget(
                          h: 100,
                          w: 100,
                          borderRadius: 15,
                        ),
                        10.pw,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ShimmerBoxWidget(w: context.mWidth / 2),
                            10.ph,
                            ShimmerBoxWidget(w: context.mWidth / 2),
                            10.ph,
                            ShimmerBoxWidget(w: context.mWidth / 2),
                          ],
                        )
                      ],
                    ),
                    10.ph,
                    const CustomDivider(),
                    10.ph,
                    const ShimmerBoxWidget(h: 55)
                  ],
                ),
              );
            }),
      ),
    );
  }
}

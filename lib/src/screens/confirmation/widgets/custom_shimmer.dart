part of confirmation;

// ignore: camel_case_types
class _customShimmer extends StatelessWidget {
  const _customShimmer();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ShimmerBoxWidget(
                    w: context.mWidth / 3,
                    h: context.mHeight / 3,
                    shape: BoxShape.circle,
                  ),
                  20.ph,
                  ShimmerBoxWidget(w: context.mWidth / 3),
                  10.ph,
                  ShimmerBoxWidget(w: context.mWidth / 2),
                  5.ph,
                  ShimmerBoxWidget(w: context.mWidth / 5),
                ],
              ),
            ),
            20.ph,
            const DottedDivider(
              gapWidth: 8,
            ),
            20.ph,
            Row(children: <Widget>[
              const ShimmerBoxWidget(w: 20, h: 20),
              10.pw,
              ShimmerBoxWidget(w: context.mWidth / 5),
            ]),
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const ShimmerBoxWidget(w: 20, h: 20),
                    10.pw,
                    ShimmerBoxWidget(w: context.mWidth / 5),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const ShimmerBoxWidget(w: 20, h: 20),
                    10.pw,
                    ShimmerBoxWidget(w: context.mWidth / 5),
                  ],
                ),
                const SizedBox()
              ],
            ),
            const Spacer(),
            const CustomDivider(),
            10.ph,
            ShimmerBoxWidget(w: context.mWidth, h: 50),
            20.ph,
            Center(
              child: ShimmerBoxWidget(w: context.mWidth / 5),
            ),
            20.ph,
          ],
        ),
      ),
    );
  }
}
